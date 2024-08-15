class AddTimeRestrictionToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :c_avble_start_time, :date
    add_column :orders, :c_avble_end_time, :date
  end
end
