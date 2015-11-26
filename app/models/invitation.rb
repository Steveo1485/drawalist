class Invitation < ActiveRecord::Base
  belongs_to :group

  validates :group_id, numericality: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :group_id, message: "has already been invited" }

  after_create :send_invitation_email

  def self.create_invites!(group, email_addresses)
    return true if email_addresses.blank?
    email_addresses.scan(/([^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,})/).flatten.each do |email|
      Invitation.create!(group: group, email: email)
    end
    return true
  end

  private

  def send_invitation_email
    InvitationsMailer.invitation(self).deliver_later
  end

end