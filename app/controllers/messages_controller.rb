class MessagesController < ApplicationController

  def show
    @receiver = User.find(params[:id])
    @histories = @receiver.histories_with(current_user).paginate(:page => params[:page], :order => 'created_at')
    respond_to do |format|
      format.html { render :partial => "shared/histories", :histories => @histories, :receiver => @receiver }
      format.js {
        render 'histories/show'
      }
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      # respond_to do |format|
      #   format.html { render :partial => "histories/message", :message => @message }
      #   format.js {
      #     render 'histories/create'
      #   }
      # end
      #user_msg :new_message, message[:msg_body].dup
      logger.info "----------start----------"
      logger.info @message.content
      event = WebsocketRails::Event.new(:new_message, data: {
        user_name:  @message.user_id, 
        received:   Time.now.to_s(:short), 
        msg_body:   ERB::Util.html_escape(@message.content) 
      })
      #WebsocketRails["system"].trigger event
      #binding.pry
      # WebsocketRails.users[@message.receiver.id.to_s].send_message :new_message, { 
      #WebsocketRails.users[@message.receiver.id.to_s].trigger event
      WebsocketRails.users.each do |connection|
        event = WebsocketRails::Event.new(:new_message, data: {
          user_name:  @message.user_id, 
          received:   Time.now.to_s(:short), 
          msg_body:   ERB::Util.html_escape(@message.content) 
        })
        connection.trigger event
      end
      # WebsocketRails.broadcast_message Event.new(:new_message, data: {
      #   user_name:  @message.poster.name, 
      #   received:   Time.now.to_s(:short), 
      #   msg_body:   ERB::Util.html_escape(@message.content) 
      # })
      # WebsocketRails.users.send_message :new_message, { 
      # user_name:  @message.poster.name, 
      # received:   Time.now.to_s(:short), 
      # msg_body:   ERB::Util.html_escape(@message.content) 
      # }
      #WebsocketRails[@message.receiver.email].trigger :new_message, @message.content
      logger.info "----------end----------"
    end
  end

  def destroy
  end

  private

    def message_params
      params.require(:message).permit(:content, :friend_id)
    end
end