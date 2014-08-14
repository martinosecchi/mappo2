# == Schema Information
#
# Table name: datasets
#
#  id          :integer          not null, primary key
#  type        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Dataset < ActiveRecord::Base
  attr_accessible :description, :title, :type
  attr_accessible :works, :work_attributes

  has_many :works
end
