class GroupPolicy < ApplicationPolicy

  def new?
    @user
  end

  def create?
    @user.id == @record.user_id
  end

  def show?
    @user.id == @record.user_id
  end

end