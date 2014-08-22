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

	def gmaps4rails_address
		[name, country].compact.join(', ')
	end

	def gmaps4rails_home_infowindow
		'<div align="center">
		<h4>'+self.name+', '+self.country+'</h4>
		<p>projects: '+self.works.length.to_s+'</p>
		</div>'
	end
end