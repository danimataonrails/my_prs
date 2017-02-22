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

class Exercise < ApplicationRecord
  #include Translatable

  belongs_to :ex_type, inverse_of: :exercises
  
  delegate :name, to: :ex_type, prefix: true

  #translate :name
  #translate :description
end
