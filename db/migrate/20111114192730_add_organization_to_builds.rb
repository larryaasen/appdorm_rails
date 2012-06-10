class AddOrganizationToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :organization_id, :integer

    add_index :builds, :organization_id
  end
end
