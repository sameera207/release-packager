class PackagesController < ApplicationController
  def index
    @commits = Package.new.git_commits
    @packages = Package.latest_first   
    @package = Package.new
  end
  
  def create
    @package = Package.new(params[:package])
    if @package.save
      @package.create_archive
      flash.now[:success] = ["sucessfully created"]
    else  
      flash.now[:errors] = @package.errors.full_messages
    end
  end
end
