class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :organization, null: false, foreign_key: {to_table: :organizations, primary_key: :user_id, on_delete: :cascade}
      t.date :start_time
      t.date :end_time
      
      t.references :address, null: false
      t.timestamps
    end
  end
end
