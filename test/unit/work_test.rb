# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start      :date
#  end        :date
#  places     :text
#  extra      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
