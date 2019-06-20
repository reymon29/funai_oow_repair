class OpenCallsController < ApplicationController
  before_action :call_id_find, only: [:show, :edit, :update, :destroy]
  def index
    @opencalls = OpenCall.where.not(status: ["Canceled", "Create Order"])
  end

  def new
    @opencall = OpenCall.new
    @product_model = Product.order(:model_no)
  end

  def create
    @opencall = OpenCall.new(open_params)
    @opencall.user = current_user
    @product_model = Product.order(:model_no)
    if @opencall.save
      redirect_to open_calls_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @product_model = Product.order(:model_no)
    if current_user.admin?
      @user = UserOnline.find_by(user: current_user)
      @user.status = "In a Call"
      @user.save
    end
  end

  def update
    @opencall.update(open_params)
    if @opencall.status == "Create Order"
      if current_user.admin?
        @user = UserOnline.find_by(user: current_user)
        @user.status = "In a Order"
        @user.user = current_user
        @user.save
      end
      redirect_to new_open_call_order_path(@opencall)
    else
      if current_user.admin?
        @user = UserOnline.find_by(user: current_user)
        @user.status = "Available"
        @user.user = current_user
        @user.save
      end
      redirect_to open_calls_path
    end
  end

  private

  def call_id_find
    @opencall = OpenCall.find(params[:id])
  end

  def open_params
    params.require(:open_call).permit(:first_name, :case_no, :last_name, :address, :address2, :city, :state, :zip, :telephone_no, :email, :product_id, :serial_number, :symptom, :status)
  end
end
