require 'spec_helper'

describe SessionsController do
  
  describe "#index" do
    before do
      login_user
    end
    
    after do
      login_user
    end
    
    context "logged in" do
      it "redirected to rooms page" do
        get :new
        response.should redirect_to(rooms_path)
      end
    end
  end
  
  describe "#create" do
    before do
      post :create, username: "username"
    end
    
    it "set session" do
      session[:username].should_not be_nil
    end
    
    it "redirected to rooms page" do
      response.should redirect_to(rooms_path)
    end
    
  end
  
  describe "#logout" do
    before do
      get :logout
    end
    
    it "set session to nil" do
      session[:username].should be_nil
    end
    
    it "redirected to login page" do
      response.should redirect_to(login_path)
    end
  end

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
      it "redirected to login page" do
        get :root
        response.should redirect_to login_path
      end
    end
  end

end
