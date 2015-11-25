class InvitationsMailer < Postman

  def invitation(email, group)
    @email = email
    @group = group
    mail(to: @email, subject: "You've been invited to join #{@group.name}")
  end

end