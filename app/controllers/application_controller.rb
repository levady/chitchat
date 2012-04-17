class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required
  
  protected
  
    def login_required
      session[:username] or redirect_to login_path
    end
  
end
