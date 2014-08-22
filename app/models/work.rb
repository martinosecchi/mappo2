# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start      :date
#  end        :date
#  places     :text
#  extra      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dataset_id :integer
#

class Work < ActiveRecord::Base
  attr_accessible :end, :extra, :name, :places, :start
  attr_accessible :locations, :location_ids, :location_attributes
  attr_accessible :dataset, :dataset_id, :dataset_attribute

  #serialize :extra, Hash #the extra field is 'text' in the database but i want it as a hash
  belongs_to :dataset
  has_one :dataset
  has_many :location_works
  has_many :locations, :through => :location_works
  accepts_nested_attributes_for :locations

  def generate_extra_hash
    if self.extra
      text=self.extra
      keys=[]
      values=[]
      hash={}
      cont=0
      text.delete!("\n")
      text.delete!("\r")
      pairs=text.split("-;-;-")
      pairs.each do |pair|
        pair.delete!("-;-;-")
        pair_array=pair.split("/:/:/")
        keys[cont]=pair_array.first
        values[cont]=pair_array.second
        cont+=1
      end
      for i in 0...keys.length
        key=keys[i]
        value=values[i]
        hash[key]=value
      end
      return_array=[keys, hash]
    end
  end

  def get_extra_hash
    if self.extra
     array_extra=self.generate_extra_hash
     keys=array_extra.second
   end
 end

 def get_extra_keys
  if self.extra
  	array_extra=self.generate_extra_hash
    keys=array_extra.first
  end
end
end
