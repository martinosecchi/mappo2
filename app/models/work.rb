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

def self.import(file, dataset_id, usr)
  spreadsheet = open_spreadsheet(file)
  spreadsheet.row(1).each do |column|
    column.downcase!
  end
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    hash = Hash[[header, spreadsheet.row(i)].transpose]
    if header.include? "project_id"
      work = find_by_project_id(hash["project_id"]) || new
    else
      work = find_by_name(hash["name"]) || new
      #se non c'è project id e viene trovato un match con il name, voglio controllare che non sia il progetto di un'altro utente
      if work.dataset_id && !usr.datasets.include?(Dataset.find(work.dataset_id))
        work = new 
      end
    end
    
    work.attributes = hash.to_hash.slice(*accessible_attributes)
    #attributi che non fanno parte del modello vengono salvati nella hash 'extra'
    keys=header - get_array_attr
    values=[]
    keys.each do |elem|
      values << hash[elem]
    end
    work.extra = Hash[[keys, values].transpose]

    Dataset.find(dataset_id).works << work
    work.save!
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
  #Roo::Spreadsheet.open(file.path) #uno che sembra funzionare per ogni tipo
end

end
