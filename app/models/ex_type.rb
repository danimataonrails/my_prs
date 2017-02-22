# == Schema Information
#
# Table name: ex_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  code       :string(4)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExType < ApplicationRecord
  #include Translatable

  has_many :exercises, inverse_of: :ex_types, dependent: :destroy

  #translate :name
end
