require 'spec_helper'

describe SessionsController do
  
  describe "#create" do
    context "when username is not blank" do
      before do
        post :create, username: "username"
      end
      
      it "set session" do
        session[:username].should_not be_nil
      end
      
      it "redirected to rooms page" do
        response.should redirect_to(rooms_path)
      end
      
      it "sanitize username session string" do
        post :create, username: "<script>alert('test')</script><b>bold</b>"
        session[:username].should eq "alert('test')bold"
      end
    end
    
    context "when session is blank" do
      before do
        post :create, username: ""
      end

      it "reset session" do
        session[:username].should be_nil
      end
      
      it "redirected to root page" do
        response.should redirect_to(root_path)
      end
      
      it "set flash error message" do
        flash[:error].should eq "Please set the username."
      end
    end
    
  end
  
  describe "#logout" do
    before do
      get :logout
    end
    
    it "set session to nil" do
      session[:username].should be_nil
    end
    
    it "redirected to root page" do
      response.should redirect_to(root_path)
    end
  end
end
