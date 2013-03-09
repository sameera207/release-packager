require 'spec_helper'

describe "ApplicationConfigs" do
  describe "GET /application_configs" do
    
    context "initial configuration" do
      
      before(:each) do
        @conf = ApplicationConfig.new
        #Capybara.javascript_driver = :webkit
      end
      
      it "should allow to create a new config", :js => true do
        visit application_configs_path
        fill_in 'application_config_name', :with => 'sample name'
        fill_in 'application_config_git_repo_path', :with => Rails.root.join('spec', 'support', 'git-repo').to_s
        select('zip', :from => 'application_config_package_type')
        click_button 'Save'
        page.should have_content("Release Packagesr sameera207")
        page.should have_content("sucessfully created")      
      end
      
      it "should not create a new config with invalid attributes", :js => true do
        visit application_configs_path
        fill_in 'application_config_name', :with => nil
        fill_in 'application_config_git_repo_path', :with => Rails.root.join('spec', 'support', 'git-repo').to_s
        select('zip', :from => 'application_config_package_type')
        click_button 'Save'
        page.should have_content("Release Packagesr sameera207")
        page.should have_content("Name can't be blank")      
      end
    end
  end
end
