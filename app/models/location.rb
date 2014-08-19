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
	acts_as_gmappable
	attr_accessible :country, :latitude, :longitude, :name, :gmaps
	attr_accessible :works, :works_attributes

	has_many :location_works
	has_many :works, :through => :location_works

	def gmaps4rails_address
  		"#{name}, #{country}"
  	end
end
