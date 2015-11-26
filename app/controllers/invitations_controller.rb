class InvitationsController < ApplicationController

  def create
    @invitation = Invitation.new(invitation_params)
    authorize(@invitation)
    if @invitation.save
      redirect_to @invitation.group, notice: 'Invitation sent!'
    else
      redirect_to @invitation.group, alert: 'Something went wrong, please try again.'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :group_id)
  end

end