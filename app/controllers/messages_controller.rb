class MessagesController < ApplicationController
  respond_to :html, :js
  
  before_filter :check_room, only: :index
  
  def index
    @messages = Message.get_messages(params[:room_id], params[:page])
    respond_with(@messages)
  end

  def create
    @message = Message.new(params[:message]
      .merge(room_id: params[:room_id],
      username: session[:username]))
      
    if @message.save
      render action: :create
    else
      render template: "messages/create_errors.js.erb"
    end
  end
  
  protected 
  
    def check_room
      unless Message::ROOM_ID.include?(params[:room_id].to_i)
        render(file: "public/404", status: :not_found)
      end
    end
    
end
