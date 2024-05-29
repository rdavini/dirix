class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.integer :number, null: false
      t.string :block, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.string :complement
      t.string :state, null: false
      t.numeric :zip, :precision => 8, null: false
      t.jsonb :location, null: false
      t.timestamps
    end
    execute "ALTER TABLE addresses ADD CONSTRAINT check_street_minimum_length CHECK (LENGTH(street) > 0)"
    execute "ALTER TABLE addresses ADD CONSTRAINT check_state_length CHECK (LENGTH(state) = 2)"
    execute "ALTER TABLE addresses ADD CONSTRAINT check_number_ge_zero CHECK (number > 0 )"
    execute "ALTER TABLE addresses ADD CONSTRAINT unique_const UNIQUE(street, number, complement, block, city)"
  end
end
