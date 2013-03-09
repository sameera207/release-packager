class ApplicationConfig < ActiveRecord::Base
  attr_accessible :git_repo_path, :name, :package_path, :package_type

  #validations
  validates :name, :presence => true
  validates :package_type, :presence => true, :format => {:with => /^(\Azip\z)|(\Atar.gz\z)$/}
  
  after_validation :validate_git_repo
  
  #return the current git configurations
  def self.config
    ApplicationConfig.try(:first)
  end
  
  #validate via Grit
  def validate_git_repo
    begin
      Grit::Repo.new(git_repo_path)
    rescue
      errors.add :base, "invalid git repo path"  
    end
  end 
   
end
