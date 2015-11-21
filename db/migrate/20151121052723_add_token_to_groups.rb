class AddTokenToGroups < ActiveRecord::Migration
  def change
    add_column(:groups, :token, :string)
    add_index(:groups, :token, unique: true)
  end
end
