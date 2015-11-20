class Group < ActiveRecord::Base
  belongs_to :user

  validates :user_id, numericality: true
  validates :name, presence: true
end