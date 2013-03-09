require 'spec_helper'

describe ApplicationConfig do
  
  before do
    @conf = FactoryGirl.create(:application_config)
  end
  
  describe "validations" do
    
    subject { @conf }
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:package_type) }
     
    it "should have onle zip, tar.gz as the package types" do
      subject.should have(0).error_on(:package_type) #valid - zip
      
      subject.package_type = '1zip' #invalid
      subject.should have(1).error_on(:package_type)
       
      #tar.gz
      subject.package_type = "tar.gz"
      subject.should have(0).error_on(:package_type)
       
      #invalid
      subject.package_type = "tar.gz1"
      subject.should have(1).error_on(:package_type)
    end
    
    it "should validate git repo path" do
      subject.should have(0).error_on(:git_repo_path) #valid path
             
      #invalid path
      subject.git_repo_path = 'not_a_valid_git_path'
      expect {subject.save!}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: invalid git repo path')
    end
  
  end
  
  describe "save" do
    
    subject { @conf }
    
    it "should save with valid data" do
      subject.save.should be true
      subject.id.should equal 1
    end
  end
  
  describe "edit" do
    
    subject { @conf }
    
    it "should update data" do
      subject.name = "new name"
      subject.save
      ApplicationConfig.find(subject.id).name.should eq "new name"
    end
  end
  
  describe "methods" do
    subject { @conf }
    it "should return the git server config details" do
      ApplicationConfig.config.should eq @conf
    end
  end
    
end
