class SessionsController < ApplicationController
  def new
    redirect_to rooms_path if session[:username]
  end

  def create
    session[:username] = params[:username]
    redirect_to rooms_path
  end
end
