class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys, id: false do |t|
      t.string :ip
      t.string :token, null: false
      t.boolean :active, default: true
      t.references :user, primary_key: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
