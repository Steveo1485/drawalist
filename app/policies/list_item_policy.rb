class ListItemPolicy < ApplicationPolicy

  def create?
    @user == @record.user
  end

end