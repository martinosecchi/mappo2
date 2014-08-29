# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country    :string(255)
#  latitude   :float
#  longitude  :float
#  gmaps      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
	geocoded_by :gmaps4rails_address
	after_validation :geocode

	attr_accessible :country, :latitude, :longitude, :name, :gmaps
	attr_accessible :works, :works_attributes

	has_many :location_works
	has_many :works, :through => :location_works

	validates :country, :presence => true

	def gmaps4rails_address
		[name, country].compact.join(', ')
	end

	def get_works_length_in_ds(openDS)
		cont=0
		works.each do |work|
			cont += 1 if work.dataset_id == openDS.id
		end
		cont
	end
	def works_in_ds(openDS)
		ret = []
		works.each do |work|
			ret << work if work.dataset_id == openDS.id
		end
		ret
	end
end