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

require 'test_helper'

class DatasetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
