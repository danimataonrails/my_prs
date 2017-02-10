# == Schema Information
#
# Table name: exercises
#
#  id            :integer          not null, primary key
#  ex_type_id_id :integer
#  name          :string           not null
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Exercise < ApplicationRecord
end
