class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required
  
  helper_method :logged_in?, :ajax_errors
  
  protected
    
    def logged_in?
      !!session[:username]
    end
    
    def login_required
      logged_in? or redirect_to root_path
    end
    
    def ajax_errors(object)
      if object.errors.any?
        if object.errors.size == 1
          errors = object.errors
            .full_messages.first.html_safe
        else
          errors = ""
      		errors << "<ul>"
      		object.errors.full_messages.each do |message|
      			errors << "<li>#{message}</li>"
      		end
      		errors << "</ul>"
        end
    	end
    	return errors.html_safe
    end
  
end
