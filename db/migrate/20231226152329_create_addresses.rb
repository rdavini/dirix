class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :block
      t.string :city
      t.string :country
      t.string :complement
      t.string :state, :limit => 2, null: false
      t.numeric :zip, :precision => 8
      t.jsonb :location, null: false
      t.timestamps
    end
    execute "ALTER TABLE addresses ADD CONSTRAINT check_number_ge_zero CHECK (number > 0 )"
    execute "ALTER TABLE addresses ADD CONSTRAINT unique_const UNIQUE(street, number, complement, block, city)"
  end
end
