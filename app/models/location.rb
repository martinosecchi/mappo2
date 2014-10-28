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
	after_validation :geocode, if: ->(obj){ obj.name_changed? or obj.country_changed? }

	attr_accessible :country, :latitude, :longitude, :name, :gmaps
	attr_accessible :works, :works_attributes

	has_many :location_works
	has_many :works, :through => :location_works

	validates :country, :presence => true

	def get_name
		if name && name!="" && name!=" " && name!=country
			return "#{name}, #{country}"
		end
		return "#{country}"
	end

	def is_geocoded?
		return latitude && longitude && latitude!="" && longitude!=""
	end

	def is_geocoded_html?
		if latitude && longitude && latitude!="" && longitude!=""
			return	'<i class="fa fa-check found"></i>'.html_safe
		end
		return '<i class="fa fa-close not-found"></i>'.html_safe
	end

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
	def get_dataset_ids(usr)
		dataset_ids=[]
		works.each do |work|
			ds=Dataset.find_by_id(work.dataset_id)
			if ds && ds.user == usr
				dataset_ids << work.dataset_id
			end
		end
		dataset_ids.uniq
	end
end