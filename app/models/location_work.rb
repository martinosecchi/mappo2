# == Schema Information
#
# Table name: location_works
#
#  id          :integer          not null, primary key
#  location_id :integer
#  work_id     :integer
#

class LocationWork < ActiveRecord::Base

  belongs_to :location
  belongs_to :work
end
