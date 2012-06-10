class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_have_organization, :except => [:new, :create]

  # GET /organizations
  # GET /organizations.json
  def index
    @page_title = "Organizations"
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @page_title = "Organization"
    @organization = Organization.find(params[:id])
    @users = User.find(:all, :conditions => ["current_organization_id = ?",  @organization.id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @page_title = "Create Organization"
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    @page_title = "Edit Organization"
    @organization = Organization.find(params[:id])
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.user_id = current_user.id

    respond_to do |format|
      if @organization.save
        ## Updated the current organization for the user
        current_user.current_organization_id = @organization.id
        current_user.save
        
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])
    
    add_user_id = params[:params][:user_id]
    if add_user_id and !add_user_id.empty?
      puts "add organization.id #{@organization.id} to user_id #{add_user_id}"
      user = User.find(add_user_id)
      if user
        user.current_organization_id = @organization.id
        user.save
        redirect_to @organization, notice: 'Organization was successfully updated.'
      else
        render action: "add_user"
      end
    else
      respond_to do |format|
        if @organization.update_attributes(params[:organization])
          format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :ok }
    end
  end
  
  # GET /organizations/add_user
  # GET /organizations/add_user.json
  def add_user
    @page_title = "Add User"
    @organization = Organization.find(current_user.current_organization_id)

    respond_to do |format|
      format.html # add_user.html.erb
      format.json { render json: @organization }
    end
  end
  
  def OrganizationsController.forceUserIntoOrganization(user)
    # Find the first created organization
    #TBD: there could be a default org instead
    @organization = Organization.find(1)

    # Update the current organization for the user
    user.current_organization_id = @organization.id
    user.save
  end
end
