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
end
