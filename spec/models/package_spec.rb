require 'spec_helper'

describe Package do
  
  before do
    @package = FactoryGirl.create(:package)
  end
  
  describe "validations" do
    
    subject { @package }
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:commit_id) }  
    it { should validate_uniqueness_of(:commit_id) }
  end
  
  describe "save" do
    
    subject { @package }
    
    it "should save with valid data" do
      subject.save.should be true
      subject.id.should equal 1
    end
  end
  
  describe "edit" do
    
    subject { @package }
    
    it "should update data" do
      subject.name = "new package name"
      subject.save
      Package.find(subject.id).name.should eq "new package name"
    end
  end
  
  
  describe "methods" do
    
    before(:each) do
      @commits = [Grit::Commit]
      Package.any_instance.stubs(:git_commits).returns(@commits)
    end
    
    context "git_commits method" do
      it "should return list of Grit::Commits" do
        pak = Package.new
        pak.git_commits.should eq @commits
      end  
    end
  end
  
end
