class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :list_id, null: false
      t.string :name, null: false
      t.string :url
      t.timestamps
    end

    add_index(:list_items, :list_id)
  end
end
