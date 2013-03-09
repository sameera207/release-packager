require 'spec_helper'

describe ApplicationConfigsController do
  describe "GET index" do
    
    #it should always render the index template
    it "should renders the :index view" do
      get :index
      response.should render_template :index
    end
    
    
    # if the configurations not yet added, then it should allow user
    # to add new configuarations 
    context "if there are no configurations added" do
      it "assigns a new @application_config" do
        application_config = ApplicationConfig.new
        get :index
        assigns(:application_config).should be_a_new(ApplicationConfig)
      end 
    end
    
    # if the configurations are already added, then it should allow user
    # to edit the configuarations
    context "if there are already configurations added" do
      before(:each) do
        @conf = FactoryGirl.create(:application_config)
      end
      it "assigns an existing @application_config" do
        get :index
        assigns(:application_config).should eq(@conf)     
      end 
    end
  end
  
  describe "POST create" do
    context "with valid attributes" do
      it "should create a new config" do
        expect{
          post :create, application_config: FactoryGirl.attributes_for(:application_config),
          :format => 'js'
        }.to change(ApplicationConfig,:count).by(1)
      end
    end
    
    context "with in-valid attributes" do
      it "should NOT create a new config" do
        expect{
          post :create, application_config: FactoryGirl.attributes_for(:invalid_application_config),
          :format => 'js'
        }.to_not change(ApplicationConfig,:count)
      end
    end
  end
  
  describe "PUT update" do
    
    before :each do
      @application_config = FactoryGirl.create(:application_config, name: "Test Config")
    end
    
    context "with valid attributes" do
      it "should update the existing conf" do
        put :update, id: @application_config, application_config: FactoryGirl.attributes_for(:application_config, name: "Edited config"),
        :format => 'js'  
        @application_config.reload
        @application_config.name.should eq("Edited config")
      end
    end
    
    context "with in-valid attributes" do
      it "should update the existing conf" do
        put :update, id: @application_config, application_config: FactoryGirl.attributes_for(:application_config, name: "Edited config", package_path: nil),
        :format => 'js'  
        @application_config.reload
        @application_config.name.should eq("Test Config")
      end
    end
    
  end
  
end
