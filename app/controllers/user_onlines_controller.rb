class UserOnlinesController < ApplicationController
  def create
    @user = current_user
    @useronline = UserOnline.new(user:  @user, status: "Available", active: true)
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
    if @online.destroy
      redirect_to open_calls_path
    else
      render 'open_calls/index'
      flash[:notice] = "Something went wrong here, please try again"
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params_status
    params.permit(:status)
  end
end
