class GroupPolicy < ApplicationPolicy

  def new?
    @user
  end

  def create?
    @user.id == @record.user_id
  end

  def show?
    @record.users.include?(@user)
  end

  def update?
    @user.id == @record.user_id
  end

end