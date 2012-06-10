require 'fileutils'
require 'uuidtools'
require 'AndroidAPK/AndroidAPK.rb'

class BuildsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_have_organization
  
  # Get /install
  def install
    @page_title = "Install Android Apps"

    @builds = Build.uniqueBuilds

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @builds }
    end
  end

  # GET /builds
  # GET /builds.json
  def index
    @page_title = "Builds"
    
    @builds = Build.uniqueBuilds
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @builds }
    end
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    @page_title = "Android APK"
    @build = Build.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build }
    end
  end

  # GET /builds/new
  # GET /builds/new.json
  def new
    @page_title = "Upload Build"
    @build = Build.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build }
    end
  end

  # GET /builds/1/edit
  def edit
    @page_title = "Builds"
    @build = Build.find(params[:id])
  end

  # POST /builds
  # POST /builds.json
  def create
    @page_title = "Builds"
    
    if !params[:build][:apk_filename] || !params[:build][:apk_filename].tempfile
      render action: "new"
    end
    
    tempFilename = params[:build][:apk_filename].tempfile.path
    original_filename = params[:build][:apk_filename].original_filename
    
    # Verify file is greater than 100 bytes
    file_size = FileTest.size(tempFilename)
    if file_size < 100
      format.html { render action: "new" }
      format.json { render json: @build.errors, status: :unprocessable_entity }
      return
    end
    
    # Verify file contains app name in AndroidManifest.xml
    #TODO: read AndroidManifest.xml
    apk = AndroidAPK.getAndroidManifestFromAPK(tempFilename)
    if apk.package.empty?
      format.html { render action: "new" }
      format.json { render json: @build.errors, status: :unprocessable_entity }
    end

    # Get the full public path
    publicPath = Rails.root.join('public').to_s

    # Create a common public base path
    publicRelativePath = File.join('public', 'apks')
    basePath = Rails.root.join(publicRelativePath).to_s
    
    # Create a random folder based on two levels deep:
    #   base_path/[a-z]/[a-z]/uuid/apk_name.apk

    # Generate a random ascii letter from 'a' to 'z'
    letter1 = Random.rand(25) + ?a.ord
    letter2 = Random.rand(25) + ?a.ord

    # Create a random folder name
    randomUUID = UUIDTools::UUID.random_create.to_s

    # The destination filename is the same as the original filename
    newFilename = original_filename

    # Create the relative path
    newRelativePath = File.join('apks', letter1.chr.to_s, letter2.chr.to_s, randomUUID)
    
    # Join the new filename with the new path
    destinationFilePath = File.join(publicPath, newRelativePath)
    
    # Make sure the destination path exists
    FileUtils.mkdir_p destinationFilePath

    # Add the filename to the destination path    
    destinationFilePath = File.join(destinationFilePath, newFilename)

    # Move temp file to the base path
    FileUtils.mv tempFilename, destinationFilePath

    # Create a relavite path from the random filename
    destinationRelativePath = File.join('', newRelativePath, newFilename)
    
    applicationName = apk.applicationLabel
    applicationName = apk.package if !applicationName || applicationName.empty?

    # Create a new build record in the database
    @build = Build.new
    @build.apk_app_name = applicationName
    @build.apk_filename = original_filename
    @build.apk_file_size = file_size
    @build.apk_local_path = destinationRelativePath
    @build.apk_package_name = apk.package.downcase    # make sure package name is lowercase since it has to be unique
    @build.apk_version_number = apk.versionName
    @build.date_uploaded = Time.now.gmtime
    @build.release_note = params[:build][:release_note]
    @build.user_id = current_user.id
    @build.organization_id = current_user.current_organization_id
    
    logger.debug "original_filename: #{original_filename}"
    logger.debug "destinationRelativePath: #{destinationRelativePath}"
    logger.debug "destinationFilePath: #{destinationFilePath}"

    respond_to do |format|
      if @build.save
        # Tell the UserMailer to send a welcome Email after save
        UserMailer.new_build_email(current_user, @build).deliver

        format.html { redirect_to @build, notice: 'Build was successfully created.' }
        format.json { render json: @build, status: :created, location: @build }
      else
        format.html { render action: "new" }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  def file_upload  
    tmp = params[:file_upload][:my_file].tempfile
    file = File.join("public", params[:file_upload][:my_file].original_filename)
    FileUtils.cp tmp.path, file
#    ... # YOUR PARSING JOB
    FileUtils.rm file
  end

  # PUT /builds/1
  # PUT /builds/1.json
  def update
    @page_title = "Builds"
    @build = Build.find(params[:id])

    respond_to do |format|
      if @build.update_attributes(params[:build])
        format.html { redirect_to @build, notice: 'Build was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @page_title = "Builds"
    @build = Build.find(params[:id])
    @build.destroy

    respond_to do |format|
      format.html { redirect_to builds_url }
      format.json { head :ok }
    end
  end
  
end