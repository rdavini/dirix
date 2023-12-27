class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers, id: false do |t|
      t.string :drivers_license_photo, limit: 300
      t.string :vehicle_doc_photo, limit: 300
      t.string :license_plate
      t.string :vehicle_brand
      t.string :vehicle_color
      t.integer :number_rides_canceled, unsigned: true, default: 0
      t.integer :avg_speed, unsigned: true, default: 0
      t.boolean :working, default: false
      t.boolean :drivers_license_approved, default: false
      t.boolean :vehicle_doc_approved, default: false

      t.references :user, primary_key: true, foreign_key: { on_delete: :cascade }

      t.references :organization, null: false, foreign_key: { to_table: :organizations, on_delete: :cascade, primary_key: :user_id }
    end
  end
end
