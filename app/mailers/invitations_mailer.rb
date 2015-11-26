class InvitationsMailer < Postman

  def invitation(invitation)
    @invitation = invitation
    @group = @invitation.group
    mail(to: @invitation.email, subject: "You've been invited to join #{@group.name}")
  end

end