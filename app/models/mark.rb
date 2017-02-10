# == Schema Information
#
# Table name: marks
#
#  id             :integer          not null, primary key
#  exerecise_id   :integer
#  acomplished_at :date             not null
#  acomplished_in :string
#  ac_time        :time
#  ac_quantity    :float
#  ac_reps        :integer
#  ac_xreps       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#

class Mark < ApplicationRecord
  belongs_to :user, inverse_of: :marks
  
  scope :by_user ->(user) { where(user_id: user) }
end
