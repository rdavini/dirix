class CreateWorkingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :working_days, id: false do |t|
      t.date :date
      t.timestamp :start_time
      t.timestamp :last_login
      t.time :total_time, default: "00:00"
      t.integer :number_rides, default: 0
      t.references :driver, null: false, foreign_key: {to_table: :drivers, primary_key: :user_id, on_delete: :cascade}

      t.timestamps
    end
    execute "ALTER TABLE working_days ADD PRIMARY KEY(driver_id, date);"
  end
end
