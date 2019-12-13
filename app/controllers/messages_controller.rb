class MessagesController < ApplicationController
  
  def index 
    @messages = Message.all.order("created_at ASC")
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(msg_params)
    if @message.save 
      ActionCable.server.broadcast 'room_channel',
                                    content: @message.content
    end
  end

  private 
  def msg_params 
    params.require(:message).permit(:content)
  end
end
