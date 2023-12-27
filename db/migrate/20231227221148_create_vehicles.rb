class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :branch
      t.string :color
      t.string :license_plate
      t.string :vehicle_doc_photo
      t.references :organization, null: false, foreign_key: {to_table: :organizations, primary_key: :user_id, on_delete: :cascade}

      t.timestamps
    end
  end
end
