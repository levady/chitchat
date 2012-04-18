class HomeController < ApplicationController
  skip_before_filter :login_required
  
  def root
    redirect_to rooms_path if logged_in?
  end
  
end
