class Message < ActiveRecord::Base
  self.per_page = 10
  
  ROOM_ID = (1..10)
  CHAT_SUBJECTS = ["Chat away!", "Trolling allowed :P", "42?"]
  
  attr_accessible :content, :room_id, :username
  
  validates :room_id, presence: true, numericality: true,
            inclusion: { :in => ROOM_ID }
  validates :username, :presence => true
  validates :content, :presence => true
  
  before_validation :sanitize_content
  before_create :publish_message
  
  def self.get_messages(room_id, page)
    where(room_id: room_id).page(page)
      .order("id DESC")
  end
  
  private
  
    def publish_message
      Pusher["#{Rails.env}_room_#{self.room_id}"]
        .trigger!("#{Rails.env}_chat_messages_event",
        username: self.username, content: self.content)
    end
    
    def sanitize_content
      self.content = Sanitize.clean self.content
    end
  
end
