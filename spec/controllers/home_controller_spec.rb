require 'spec_helper'

describe HomeController do

  describe "#root" do
    context "logged in" do
      before do
        login_user
      end
      
      after do
        logout_user
      end
      
      it "redirected to rooms page" do
        get :root
        response.should redirect_to rooms_path
      end
    end
    
    context "logged out" do
      it "redirected to root page" do
        get :root
        response.should render_template(:root)
      end
    end
  end

end
