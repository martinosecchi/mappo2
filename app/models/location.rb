# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country    :string(255)
#  lat        :float
#  lng        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  attr_accessible :country, :lat, :lng, :name
  attr_accessible :works, :works_attributes

  has_many :location_works
  has_many :works, :through => :location_works
end
