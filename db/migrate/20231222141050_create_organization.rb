class CreateOrganization < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: false do |t|
      t.references :user, primary_key: true, foreign_key: { on_delete: :cascade }
    end
  end
end
