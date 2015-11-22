class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validates :user_id, numericality: true
  validates :group_id, numericality: true

end