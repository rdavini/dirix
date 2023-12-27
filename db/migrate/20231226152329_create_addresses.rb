class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :block
      t.string :city
      t.string :state, :limit => 2
      t.numeric :zip, :precision => 8
      
      t.timestamps
    end
    execute "ALTER TABLE addresses ADD CONSTRAINT check_number_ge_zero CHECK (number > 0 )"
  end
end
