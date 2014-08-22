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

require 'test_helper'

class DatasetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
