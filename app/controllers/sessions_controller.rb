class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def new
    redirect_to rooms_path if logged_in?
  end

  def create
    if params[:username].blank?
      reset_session
      redirect_to login_path, flash: { error: "Please set the username." }
    else
      session[:username] = params[:username]
      redirect_to rooms_path
    end
  end
  
  def logout
    reset_session
    redirect_to login_path
  end
  
  def root
    if logged_in?
      redirect_to rooms_path
    else
      logout
    end
  end
  
end
