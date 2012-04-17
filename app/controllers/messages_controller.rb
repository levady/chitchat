class MessagesController < ApplicationController
  respond_to :html, :js
  
  def index
    @messages = Message.get_messages(params[:room_id], params[:page])
    
    respond_with(@messages)
  end

  def create
    @message = Message.create!(params[:message]
      .merge(room_id: params[:room_id], username: session[:username]))
      
  rescue ActiveRecord::ActiveRecordError, Pusher::Error
    render js: "alert('Oops something went wrong. Please try again.');",
      status: :internal_server_error
  end
end
