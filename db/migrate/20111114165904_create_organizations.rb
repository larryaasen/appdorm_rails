class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_index :organizations, :user_id
  end
end
