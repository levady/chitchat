require 'spec_helper'

describe Message do
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:room_id) }
  it { should validate_numericality_of(:room_id) }
  Message::ROOM_ID.each do |id|
    it { should allow_value(id).for(:room_id) }
  end
  it { should_not allow_value(5).for(:room_id) }
  
  describe ".get_messages" do
    let(:messages) { [Message.new] }
    
    before do
      messages.stub_chain(:page, :order)
    end
    
    it "returns messages for specific room" do
      Message.should_receive(:where)
        .with(room_id: 2).and_return(messages)
        
      Message.get_messages(2, 1)
    end
  end
  
  describe "#publish_message" do
    let(:message) { Message.new(username: "username", content: "content", room_id: 1) }
    
    it "push the right content" do
      Pusher["room_#{message.room_id}"].should_receive(:trigger!)
        .with('chat_messages_event', 
        { username: message.username, content: message.content })
        .and_return(true)
        
      message.send(:publish_message)
    end
  end
  
end
