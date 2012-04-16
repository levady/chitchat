class Message < ActiveRecord::Base
  
  ROOM_ID = [1, 2, 3]
  
  attr_accessible :content, :room_id, :username
  
  validates :room_id, :presence => true, :numericality => true,
            :inclusion => { :in => ROOM_ID }
  validates :username, :presence => true
  
  after_create :publish_message
  
  private
  
    def publish_message
      Pusher["room_#{self.room_id}"].trigger!('chat_messages_event',
        username: self.username, content: self.content)
    end
  
end
