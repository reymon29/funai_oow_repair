class UserOnlinesController < ApplicationController
  def create
    @user = current_user
    @useronline = UserOnline.new(user:  @user, status: "Available", active: true)
    authorize @useronline
    if @useronline.save
      redirect_to root_path
    else
      render 'open_calls/index'
      flash[:notice] = "Something went wrong here, please try again"
    end
  end

  def destroy
    @user = find_user
    @online = UserOnline.find_by(user: @user)
    authorize @online
    if @online.destroy
      redirect_to root_path
    else
      render 'open_calls/index'
      flash[:notice] = "Something went wrong here, please try again"
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
