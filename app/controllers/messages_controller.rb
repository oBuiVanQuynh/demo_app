class MessagesController < ApplicationController

  def new
  end

  def create
    user = User.find params[:user_id]
    @message = current_user.messages.build message_params
    @message.update_attributes(friend_id: user.id) 
    respond_to do |format|
        format.html
        format.js
    end
  end

  def destroy
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end