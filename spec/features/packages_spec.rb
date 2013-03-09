require 'spec_helper'

describe "Packages" do
  describe "GET /packages" do
     
     before(:each) do
      @commits = Commit.list
      Package.any_instance.stubs(:git_commits).returns(@commits)
      Package.any_instance.stubs(:create_archive).returns(true)
      PackagesController.any_instance.stubs(:package_path).returns("/")
      @packages = [FactoryGirl.create(:package), FactoryGirl.create(:package2)]
     end
     
     it "should load all the packages" do
       visit packages_path
       page.should have_content("sample package")
       page.should have_content("old package")
     end
     
     it "should view download button" do
       visit packages_path
       page.should have_content("download")
     end
      
     it "should view re-package button" do
       visit packages_path
       page.should have_content("re-package")
     end
      
     it "should allow to create a new package", :js => true do
       clean_packages
       visit packages_path
       all('.commit_row', :text => @commits.first.id.to_s).first.click
       fill_in 'package_commit_id', :with => @commits.first.id
       fill_in 'package_name', :with => 'sample name'
       click_button 'Save'
       page.should have_content("sucessfully created")
     end
      
      
  end
  
  class Commit
    attr_accessor :id, :author, :committed_date
    
    def self.list
      commits = []
      (1..3).each do |i|
        c = Commit.new
        c.id = i
        c.author = "author#{i}"
        c.committed_date = DateTime.now
        commits << c
      end
      commits    
    end
  
  end
  
  def clean_packages
    Package.destroy_all
  end
    
end