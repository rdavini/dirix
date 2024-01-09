class CreateWarehouses < ActiveRecord::Migration[7.0]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: {to_table: :organizations, primary_key: :user_id, on_delete: :cascade}
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
