class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.integer :paired_user_id

      t.timestamps
    end

    add_index(:lists, :user_id)
    add_index(:lists, :group_id)
    add_index(:lists, :paired_user_id)
    add_index(:lists, [:user_id, :group_id])
    add_index(:lists, [:paired_user_id, :group_id])
  end
end
