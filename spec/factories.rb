Factory.define :build do |build|
#  @user = User.new(:name => "Test Build", :email => DateTime.current.to_s(0), :password => "TestBuild")
#  build.user_id @user.id
  build.apk_app_name "Moviefone"
  build.apk_filename "moviefone-1.8.31.1.apk"
  build.apk_file_size 98000
  build.apk_local_path "db/apks/test1"
  build.apk_version_number "1.8.31.1"
  build.date_uploaded Time.now
  build.release_note "Added ticket purchasing."
  build.user_uploaded "LarryAasen"
end
