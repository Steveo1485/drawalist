class Invitation < ActiveRecord::Base
  belongs_to :group

  validates :group_id, numericality: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :group_id, message: "has already been invited" }

  def self.open
    where(is_member: false)
  end

  def self.send_invites!(group, email_addresses)
    return true if email_addresses.blank?
    email_addresses.match(/([^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,})/) do |email|
      Invitation.create!(group: group, email: email)
    end
    return true
  end

end

