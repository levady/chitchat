class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
    redirect_to rooms_path if session[:username]
  end

  def create
    session[:username] = params[:username]
    redirect_to rooms_path
  end
  
  def logout
    reset_session
    redirect_to login_path
  end
  
end
