# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :string(255)
#  start      :date
#  end        :date
#  places     :text
#  extra      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dataset_id :integer
#

class Work < ActiveRecord::Base
  attr_accessible :end, :extra, :name, :places, :project_id, :start
  attr_accessible :locations, :location_ids, :location_attributes
  attr_accessible :dataset, :dataset_id, :dataset_attribute
  attr_accessor :extra_keys, :extra_values

  serialize :extra, Hash #the extra field is 'text' in the database but i want it as a hash
  belongs_to :dataset
  has_one :dataset
  has_many :location_works
  has_many :locations, :through => :location_works
  accepts_nested_attributes_for :locations

  validates :name, :presence => true

def self.get_array_attr #usato in import qui sotto
  array_attr=[]
  accessible_attributes.each do |attr|
    array_attr.push attr.to_s if attr!=""
  end
  array_attr
end

def self.import(file, dataset_id)
  spreadsheet = open_spreadsheet(file)
  spreadsheet.row(1).each do |column|
    column.downcase!
  end
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    hash = Hash[[header, spreadsheet.row(i)].transpose]
    if header.include? "project_id"
      work = find_by_project_id_and_dataset_id(hash["project_id"], dataset_id) || new
    else
      work = find_by_name_and_dataset_id(hash["name"], dataset_id) || new
    end

    work.attributes = hash.to_hash.slice(*accessible_attributes)
    #attributi che non fanno parte del modello vengono salvati nella hash 'extra'
    keys=header - get_array_attr
    values=[]
    keys.each do |elem|
      values << hash[elem]
    end
    if hash["extra"]
      keys << "extra"
      values << hash["extra"]
    end
    work.extra = Hash[[keys, values].transpose]

    Dataset.find(dataset_id).works << work
    work.save!
    Work.create_locations(work)
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.ods' then Roo::OpenOffice.new(file.path, file_warning: :ignore) 
  when '.csv' then Roo::CSV.new(file.path, file_warning: :ignore)
  when '.xls' then Roo::Excel.new(file.path, file_warning: :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, file_warning: :ignore)
  else raise "File type not supported: #{file.original_filename}"
  end
end

private 

def self.create_locations(work)
  prima=work.locations
  work.locations=[]
    arrayplaces=CSV.parse_line work.places.gsub ", ", "," #funziona solo senza spazi tra le virgole
    arrayplaces.each do |a|
      arrloc=Geocoder.search a
      #arrl è un array di oggetti del geocoder, punterei sul first per trovare country e coords
      unless arrloc.blank?
        country=arrloc.first.country
        lat=arrloc.first.latitude
        lng=arrloc.first.longitude
        Work.save_location(work, a, country, lat, lng)
      else

      end
    end#arrayplaces each
    if work.locations != prima
      #-> sono state rimosse o aggiunte delle locations nel processo di update
      #se alcune di quelle tolte adesso non hanno più progetti associati le elimino
      mismatch=false
      prima.each do |before|
        unless work.locations.include? before #se non c'è più
          mismatch=true
          break
        end
      end
      Location.destroy_unused if mismatch
    end #if != prima
  end

  def self.check_diff_name_location(loc, name, country, lat, lng)
    if !Location.find_by_name_and_country(name, country) && Location.find_by_latitude_and_longitude(lat, lng)
      #in questo caso ci sono due posti con name diverso ma stesse coordinate.. 
      #cerco di tenere il nome abbastanza generico, tipo la città se c'è o se no il nome usato nell'address
      georesults=Geocoder.search [lat, lng]
      unless georesults.blank?
        if georesults.first.city
          loc.name=georesults.first.city
        else 
          if georesults.first.data["address_components"].first["long_name"]
            loc.name=georesults.first.data["address_components"].first["long_name"]
          else
            loc.name=Work.capitalize_names(name) #se non trovo quegli altri nomi devo sovrascrivere
          end
        end
      else #unless

      end
    else
      loc.name=Work.capitalize_names(name)
    end
  end

  def self.save_location(work, name, country, lat, lng)
    loc = Location.find_by_name_and_country(name, country) || Location.find_by_latitude_and_longitude(lat, lng) || Location.new
    loc.name=Work.capitalize_names(name)
    loc.country=country
    loc.latitude=lat
    loc.longitude=lng
    work.locations << loc if !(work.locations.include? loc) #la aggiungo se non è già nella lista
    loc.save!
  end

  def self.capitalize_names(name)
    if name
      arr=name.split " "
      arr.each do |n|
        n.capitalize!
      end
      arr.join " "
    end
  end

  def self.check_n_destroy_locations(work)
    work.locations.each do |location|
      if location.works.length==1 #hanno solo il work che sto distruggendo
        location.destroy
      end
    end
  end

  def self.remove_location_from(work, loc)
    if work.locations.include? loc
      work.locations.delete loc
      if loc.works.length==1
        loc.destroy
      end
    end
  end

  def self.rewrite_all_places_from_locations
    Work.all.each do |work|
      if work.places && work.locations
        #if work.places.include?(")") || work.places.include?(";")
          work.places=""
          work.locations.sort.each do |loc|
            work.places << loc.name
            unless loc==work.locations.sort.last
              work.places << "," 
            end
          end
          work.save
        #end
      end
    end
  end
end
