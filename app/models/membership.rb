class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validates :user_id, numericality: true
  validates :group_id, numericality: true
  validates :user_id, uniqueness: { scope: :group_id, message: "is already a member of this group" }

  after_create :create_list

  private

  def create_list
    List.create(user: user, group: group)
  end

end