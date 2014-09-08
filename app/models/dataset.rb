# == Schema Information
#
# Table name: datasets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  category    :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  work_id     :integer
#

class Dataset < ActiveRecord::Base
  attr_accessible :description, :title
  attr_accessible :works, :work_attributes, :work_ids, :user_id

  belongs_to :work
  has_many :works
  has_many :locations, :through => :works 
  accepts_nested_attributes_for :works
  belongs_to :user
end
