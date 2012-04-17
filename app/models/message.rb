class Message < ActiveRecord::Base
  
  ROOM_ID = [1, 2, 3]
  
  attr_reader :prev
  attr_accessible :content, :room_id, :username
  
  validates :room_id, :presence => true, :numericality => true,
            :inclusion => { :in => ROOM_ID }
  validates :username, :presence => true
  
  before_create :publish_message
  
  def self.get_messages(room_id)
    where(room_id: room_id).limit(20)
      .order("id DESC").reverse
  end
  
  private
  
    def publish_message
      Pusher["room_#{self.room_id}"].trigger!('chat_messages_event',
        username: self.username, content: self.content)
    end
  
end
