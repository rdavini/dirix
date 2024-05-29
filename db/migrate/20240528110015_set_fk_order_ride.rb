class SetFkOrderRide < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :orders, :rides, unique: true

    execute "alter table orders add constraint unique_ride_id UNIQUE(ride_id);"
  end
end
