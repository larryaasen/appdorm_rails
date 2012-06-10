class ApplicationController < ActionController::Base
  protect_from_forgery

  has_mobile_fu
  
  # Needed for HTTP Basic Authentication
  before_filter :authenticate

  def must_have_organization
    # If the user does not have any organizations
    if !current_user
    elsif !current_user.organizations or current_user.organizations.empty?
      if Organization.count < 1
        @organization = Organization.new
        flash[:alert] = "You must first create an Organization."
        redirect_to :action => 'new', :controller => 'organizations'
      else
        OrganizationsController.forceUserIntoOrganization(current_user)
      end
    end
  end

  protected
  
  # Provide HTTP Basic Authentication
  def authenticate
    if !request.path.eql?("/")
      authenticate_or_request_with_http_basic do |username, password|
        username == RailsAppdorm::Application.config.auth_username && password == RailsAppdorm::Application.config.auth_password
      end
    end
  end 

end
