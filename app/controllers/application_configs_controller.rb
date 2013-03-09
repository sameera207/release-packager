class ApplicationConfigsController < ApplicationController
  respond_to :js, :html
  
  def index
    @application_config = render_application_config
  end
  
  
  def create
    @application_config = ApplicationConfig.new(params[:application_config])
    if @application_config.save
      flash.now[:success] = ["sucessfully created"]
    else  
      flash.now[:errors] = @application_config.errors.full_messages
    end
  end
  
  def update
    @application_config = ApplicationConfig.find(params[:id])
    if @application_config.update_attributes(params[:application_config])
      flash.now[:success] = ["sucessfully updated"]
    else  
      flash.now[:errors] = @application_config.errors.full_messages
    end
  end
  
  private
  def render_application_config
    (ApplicationConfig.all.length == 0) ? (ApplicationConfig.new) : (ApplicationConfig.first) 
  end
  
end
