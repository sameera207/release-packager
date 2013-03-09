require 'spec_helper'

describe "Packages" do
  describe "GET /packages" do
     
     before(:each) do
      @commits = Commit.list
      Package.any_instance.stubs(:git_commits).returns(@commits)
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
     
     it "should allow to create a new package" do
       visit packages_path
       click_link(@commits.first.id)
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
    
end