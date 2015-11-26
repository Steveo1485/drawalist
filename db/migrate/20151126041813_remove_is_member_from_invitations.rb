class RemoveIsMemberFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :is_member
  end
end
