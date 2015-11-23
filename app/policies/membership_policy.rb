class MembershipPolicy < ApplicationPolicy

  def new?
    @user == @record.user
  end

  def create?
    @user == @record.user
  end
end