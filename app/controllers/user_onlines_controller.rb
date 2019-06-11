class UserOnlinesController < ApplicationController
  def create
    @user = current_user
    @status = "Online"
    @useronline = UserOnline.new(user:  @user, status: @status)
    @useronline.save
  end
  def update
  end
end
