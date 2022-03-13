class AddAliasNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :alias_name, :string
  end
end
