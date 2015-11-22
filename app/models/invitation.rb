class Invitation < ActiveRecord::Base
  belongs_to :group

  validates :group_id, numericality: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :group_id, message: "has already been invited" }
end

