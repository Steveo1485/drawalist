class Group < ActiveRecord::Base
  has_secure_token

  belongs_to :admin_user, foreign_key: :user_id, class_name: 'User'
  has_many :memberships
  has_many :users, through: :memberships

  validates :user_id, numericality: true
  validates :name, presence: true
end