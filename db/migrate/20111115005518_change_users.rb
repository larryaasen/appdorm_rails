class ChangeUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :current_organization_id, 0
  end
end
