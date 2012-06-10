class CreateBuilds < ActiveRecord::Migration
  def change
    create_table(:builds) do |t|
      t.integer  :user_id
      t.string   :apk_app_name
      t.datetime :date_uploaded
      t.string   :apk_filename
      t.integer  :apk_file_size
      t.string   :apk_local_path
      t.string   :apk_package_name
      t.string   :apk_version_number
      t.string   :release_note

      t.timestamps
    end

    add_index :builds, :user_id
    add_index :builds, :apk_package_name
  end

end
