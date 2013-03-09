class PackagesController < ApplicationController
  def index
    load_details
  end
  
  def create
    @package = Package.new(params[:package])
    @package.package_path = package_path(params[:package][:commit_id])
    if @package.save
      @package.create_archive
      flash.now[:success] = ["sucessfully created"]
    else  
      flash.now[:errors] = @package.errors.full_messages
    end
    load_details
  end
  
  def download
    package = Package.find(params[:id])
    send_file(package.package_path)
  end
  
  private
  #loading data for the initial screen
  def load_details
    @commits = Package.new.git_commits
    @packages = Package.latest_first   
    @package = Package.new
  end
  
  #create package path
  def package_path(commit_id)
    conf = ApplicationConfig.config
    "#{PACKAGE_PATH}/#{commit_id}.#{conf.package_type}"
  end
  
end
