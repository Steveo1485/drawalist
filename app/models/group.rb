class Group < ActiveRecord::Base
  has_secure_token

  belongs_to :admin_user, foreign_key: :user_id, class_name: 'User'

  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :lists, dependent: :destroy

  validates :user_id, numericality: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, message: "already used" }

  after_create :create_admin_membership!

  private

  def create_admin_membership!
    Membership.create!(group: self, user: self.admin_user)
  end

end