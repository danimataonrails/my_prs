# == Schema Information
#
# Table name: marks
#
#  id             :integer          not null, primary key
#  exercise_id    :integer
#  acomplished_at :date             not null
#  acomplished_in :string
#  ac_time        :time
#  ac_quantity    :float
#  ac_reps        :integer
#  ac_xreps       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#

require 'test_helper'

class MarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
