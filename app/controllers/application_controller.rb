class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required
  
  helper_method :logged_in?
  
  protected
    
    def logged_in?
      !!session[:username]
    end
    
    def login_required
      logged_in? or redirect_to login_path
    end
  
end
