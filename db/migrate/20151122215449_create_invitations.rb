class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :group_id, null: false
      t.string :email, null: false
      t.boolean :is_member, default: false

      t.timestamps
    end

    add_index(:invitations, :group_id)
    add_index(:invitations, :email)
    add_index(:invitations, :is_member)
    add_index(:invitations, [:group_id, :is_member])
  end
end
