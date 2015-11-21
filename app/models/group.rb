class Group < ActiveRecord::Base
  has_secure_token

  belongs_to :user

  validates :user_id, numericality: true
  validates :name, presence: true
end