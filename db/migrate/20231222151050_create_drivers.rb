class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers, id: false do |t|
      t.integer :avg_speed, unsigned: true, default: 0, null: false
      
      t.references :user, primary_key: true, foreign_key: { on_delete: :cascade }

      t.references :organization, null: false, foreign_key: { to_table: :organizations, on_delete: :cascade, primary_key: :user_id }
    end
  end
end
