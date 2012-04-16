class MessagesController < ApplicationController
  def index
    @messages = Message.where(room_id: params[:room_id])
      .limit(20).order("id desc").reverse
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
