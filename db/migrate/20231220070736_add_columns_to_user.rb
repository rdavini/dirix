class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string, :limit => 25
    add_column :users, :photo, :string, :limit => 300
    add_column :users, :role, :integer, :default => 0
  end
end
