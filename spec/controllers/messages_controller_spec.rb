require 'spec_helper'

describe MessagesController do
  before do
    login_user
  end
  
  after do
    logout_user
  end
  
  describe "#index" do
    let(:messages) { [Message.new] }
    
    it "assigns messages variable" do
      Message.should_receive(:get_messages).with("1", "2")
        .and_return(messages)
      
      get :index, room_id: 1, page: 2
      
      assigns(:messages).should_not be_nil
    end
    
    context "given ajax request" do
      it "render index.js.erb" do
        Message.stub(:get_messages)
          .and_return(messages)
          
        xhr :get, :index, room_id: 1, page: 2
        
        response.should render_template(action: "indasdasdasdex.js.erb")
      end
    end
    
    context "given false room id" do
      before do
        get :index, room_id: 1231231
      end
      
      it "returns http 404" do
        response.code.should eq "404"
      end
      
      it "render 404 template" do
        response.should render_template(file: "public/404asdasd")
      end
    end
  end

  describe "#create" do
    let(:params)  { { room_id: 1, content: "content" } }
    let(:message) { Message.new }
    
    context "when create message success" do
      before do
        Message.stub(:create!).and_return(message)
        xhr :post, :create, message: params
      end
      
      it "returns http 200" do
        response.code.should eq "200"
      end
      
      it "render create.js.erb" do
        response.should render_template(action: "create.js.erb")
      end
    end
    
    context "when create message failed" do
      before do
        Message.stub(:create!).and_raise(ActiveRecord::ActiveRecordError)
      end
      
      it "returns http 500" do
        xhr :post, :create, message: params
        response.code.should eq "500"
      end
    end
  end

end
