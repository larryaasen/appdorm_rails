require 'uri'

class UserMailer < ActionMailer::Base
  default :from  => RailsAppdorm::Application.config.user_mailer_default_from
  
  def welcome_email(user)
    @user = user
    @url  = RailsAppdorm::Application.config.user_mailer_domain
    mail(:to => user.email,
         :subject => "Welcome to AppDorm")
  end
  
  def new_build_email(user, build)
    @user = user
    @build = build
    if user.name and !user.name.empty?
      from = "#{user.name} <#{user.email}>"
    else     
    from = user.email
    end
    
    @organization = Organization.find(user.current_organization_id)
    
    @full_path = URI.join(root_url, URI.escape(build.apk_local_path)).to_s

    # Find all users in the current organization
    @recipients = User.find(:all, :conditions => ["current_organization_id = ?", user.current_organization_id])
    emails = @recipients.collect(&:email).join(";")
    
    mail(:bcc => emails,
         :from => from,
         :subject => "#{build.apk_app_name} #{build.apk_version_number} was posted")
  end
end
