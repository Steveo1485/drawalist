class UserPolicy < ApplicationPolicy

  def new?
    true
  end

  def show?
    @user == @record
  end

end