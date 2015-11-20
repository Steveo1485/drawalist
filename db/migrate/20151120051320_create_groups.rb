class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index(:groups, :user_id)
  end
end
