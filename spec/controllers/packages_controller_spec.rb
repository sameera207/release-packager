require 'spec_helper'

describe PackagesController do
  
  before(:each) do
    @commits = [Grit::Commit]
    Package.any_instance.stubs(:git_commits).returns(@commits)
    @packages = [FactoryGirl.create(:package), FactoryGirl.create(:package2)]
  end

  describe "GET index" do
    #it should always render the index template
    it "should renders the :index view" do
      get :index
      response.should render_template :index
    end
    
    context "commit list" do
      it "should get the commit list" do
        get :index
        assigns(:commits).should eq(@commits)     
      end
    end
    
    context "packages list" do
      it "should get the packages list" do
        get :index
        assigns(:packages).should eq(@packages)     
      end
    end
    
    context "add new package" do
      it "should allow to add a new package" do
        get :index
        assigns(:package).should be_a_new(Package)
      end
    end
    
    
  end
end
