class MessagesController < ApplicationController

  def new
  end

  def create
    user = User.find params[:user_id]
    message = current_user.messages.build message_params
    message.update_attributes(friend_id: user.id, user_id: current_user.id) 
    redirect_to :back
  end

  def destroy
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end