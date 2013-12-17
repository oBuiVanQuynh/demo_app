class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def edit
  end

  def update
    if user_params
      current_user.update_attributes user_params
    end
    redirect_to user_path current_user
  end

  private
  def user_params
    params.require(:user).permit :name, :birthday, :gender, :company
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to user_path(current_user) unless current_user==@user
  end 
end