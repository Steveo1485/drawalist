class InvitationPolicy < ApplicationPolicy

  def create?
    @record.group && (@record.group.admin_user == @user)
  end

end