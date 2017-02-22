# == Schema Information
#
# Table name: exercises
#
#  id          :integer          not null, primary key
#  ex_type_id  :integer
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
