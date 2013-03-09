class Package < ActiveRecord::Base
  attr_accessible :commit_id, :name
  validates :name, :presence => true
  validates :commit_id, :presence => true
  validates :commit_id, :uniqueness => true 

  scope :latest_first, lambda {
    {:order => "created_at desc"}
  }

  

  def git_commits
    unpackaged_commits = []
    repo = Grit::Repo.new(ApplicationConfig.config.git_repo_path)
    commits = repo.commits
    
    commits.each do |commit| 
      unpackaged_commits << commit unless (packaged?(commit.id))
    end
    unpackaged_commits
  end
  
  def packaged?(commit_id)
    count = 0
    packages = Package.latest_first
    packages.each do |pak|
      count += 1 if (pak.commit_id == commit_id)
    end
    (count == 0) ? false : true
  end
  
  def create_archive
    conf = ApplicationConfig.config
    repo = Grit::Repo.new(conf.git_repo_path)
    file_name = "#{commit_id}.#{conf.package_type}"
    repo.archive_to_file(commit_id, nil,"#{Rails.root}/public/archives/#{file_name}", nil, conf.package_type)
  end 
  
end
