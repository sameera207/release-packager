module ApplicationHelper
  #display flash message with 
  #twitter bootsrap style
  def flash_display
    response = "<div class='alert #{alert_class}'>"
    response += "<button type='button' class='close' data-dismiss='alert'>x</button>"
    flash.each do |name, msg|
      msg.each do |m|
        response = response + content_tag(:p, m)  
      end
    end
    response += "</div>"
    flash.discard
    response
  end
  
  #format date time
  def time_format time
    time.strftime("%m/%d/%Y at %I:%M%p")
  end
  
  private
  def alert_class
    css_class = case flash.first[0]
      when :errors then "alert-error"
      when :success then "alert-success"  
    end
    css_class  
  end
end
