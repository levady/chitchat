class MessagesController < ApplicationController
  
  def index
    @messages = Message.get_messages(params[:room_id])
  end

  def create
    @message = Message.new(params[:message]
      .merge(room_id: params[:room_id], username: session[:username]))
      
    if @message.save
      head :ok
    else
      head :internal_server_error
    end
  end
end
