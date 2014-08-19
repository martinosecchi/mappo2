# == Schema Information
#
# Table name: datasets
#
#  id          :integer          not null, primary key
#  category        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Dataset < ActiveRecord::Base
  attr_accessible :description, :title, :category
  attr_accessible :works, :work_attributes, :work_ids

  belongs_to :work
  has_many :works
  has_many :locations, :through => :works 
  accepts_nested_attributes_for :works
end
