class Build < ActiveRecord::Base
  attr_accessible :release_note, :date_uploaded, :apk_filename,
    :apk_file_size, :apk_app_name, :apk_local_path, :apk_package_name, :apk_version_number

  belongs_to :user            # foreign key user_id
  belongs_to :organization    # foreign key organization_id

  default_scope :order => 'builds.created_at DESC'    # default ordering of builds when using user.builds

  validates :user_id, :presence => true
  validates :organization_id, :presence => true

  validates :apk_app_name,
    :presence => true,
    :allow_blank => false,
    :length => { :maximum => 255 }

  validates :apk_filename,
    :presence => true,
    :allow_blank => false,
    :length => { :maximum => 255 }

  validates :apk_file_size,
    :allow_nil => true,
    :numericality => { :only_integer => true }
    
  validates :apk_local_path,
    :presence => true,
    :allow_blank => false
    
  validates :apk_package_name,
    :presence => true,
    :allow_blank => false
    
  validates :apk_version_number,
    :allow_blank => true,
    :length => { :minimum => 1, :maximum => 50 }

  validates :date_uploaded,
    :presence => true,
    :allow_nil => false
  
  validates :release_note,
    :allow_blank => true,
    :length => { :minimum => 3, :maximum => 5000 }

  def fileSizeAbbreviated
    oneKB = 1024
    oneMB = oneKB * oneKB
    return "#{apk_file_size} bytes" if apk_file_size < oneKB
    return "#{apk_file_size / oneKB} KB" if apk_file_size < oneMB
    return "#{apk_file_size / oneMB}.#{(((apk_file_size % oneMB) / oneMB.to_f)*10).round} MB"
  end

  def Build.uniqueBuilds
    # query for builds grouped by package name returning the most recent of each package name
    builds = Build.where("id in (SELECT max(id) FROM builds GROUP BY apk_package_name)")

    # Order the builds by apk_app_name
    builds.sort_by { |build| [build.apk_app_name] }
  end
end
