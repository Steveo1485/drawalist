class List < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validates :user_id, numericality: true
  validates :group_id, numericality: true
  validates :paired_user_id, numericality: true, allow_blank: true

end