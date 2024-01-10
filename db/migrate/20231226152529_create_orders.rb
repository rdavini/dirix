class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.date :start_time
      t.date :end_time
      t.integer :distance_from_src, default: 0

      t.references :organization, null: false, foreign_key: {primary_key: :user_id }
      t.references :address, null: false, foreign_key: true
      t.references :ride, null: true, default: :null
      t.timestamps
    end
  end
end
