class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @user = current_user
  end
end
