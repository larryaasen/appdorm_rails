require 'spec_helper'

describe BuildsController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @build = Factory(:build)
      response.should be_success
    end
    
    it "should be successful" do
      get :show, :id => @build
      response.should be_success
    end

    it "should be successful" do
      get :show, :id => @build
      assigns(:build).should == @build  
    end

#    it "should include the build's apk_app_name" do
#      get :show, :id=>@build
#      response.should have_selector("h1", :content=>@build.apk_app_name)
#    end
    
#    it "should have a APK apk_filename" do
#      get :show, :id=>@build
#      response.should have_selector("h1>link", :content=>@build.apk_filename)
#    end
  end
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end

#    it "should have the right title" do
#      get :new
#      response.should have_selector("title", :content => "Add Build")
#    end
 end
end
