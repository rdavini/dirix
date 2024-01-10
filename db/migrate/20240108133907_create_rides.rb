class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.references :working_day, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: {primary_key: :user_id}
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
