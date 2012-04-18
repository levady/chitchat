class SessionsController < ApplicationController
  skip_before_filter :login_required
  
  def create
    if params[:username].blank?
      reset_session
      redirect_to root_path, flash: { error: "Please set the username." }
    else
      session[:username] = Sanitize.clean params[:username]
      redirect_to rooms_path
    end
  end
  
  def logout
    reset_session
    redirect_to root_path
  end
  
  def root
    if logged_in?
      redirect_to rooms_path
    else
      render action: :new
    end
  end
  
end
