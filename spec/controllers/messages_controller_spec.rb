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
    
    context "ajax request" do
      it "render index.js.erb" do
        Message.stub(:get_messages)
          .and_return(messages)
          
        xhr :get, :index, room_id: 1, page: 2
        
        response.should render_template(template: "index.js.erb")
      end
    end
  end

  describe "#create" do
    let(:params)  { { room_id: 1, content: "content" } }
    let(:message) { Message.new }
    
    context "saving success" do
      before do
        Message.stub(:new).and_return(message)
        message.stub(:save).and_return(true)
      end
      
      it "returns http 200" do
        xhr :post, :create, message: params
        response.code.should == "200"
      end
    end
    
    context "saving failed" do
      before do
        Message.stub(:new).and_return(message)
        message.stub(:save).and_return(false)
      end
      
      it "returns http 500" do
        xhr :post, :create, message: params
        response.code.should == "500"
      end
    end
  end

end
