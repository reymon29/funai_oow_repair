class OpenCallsController < ApplicationController
  before_action :call_id_find, only: [:show, :edit, :update, :destroy]

  def index
    @opencalls = policy_scope(OpenCall).where.not(status: ["Canceled", "Create Order"])
  end

  def new
    @opencall = OpenCall.new
    @product_model = Product.order(:model_no)
    authorize @opencall
  end

  def create
    @opencall = OpenCall.new(open_params)
    @opencall.user = current_user
    @product_model = Product.order(:model_no)
    authorize @opencall
    if @opencall.save
      mail = OrderMailer.with(call: @opencall).create_call
      mail.deliver_now
      redirect_to open_calls_path
    else
      render :new
    end
  end

  def show
    authorize @opencall
  end

  def edit
    authorize @opencall
    @product_model = Product.order(:model_no)
    if current_user.admin?
      @user = UserOnline.find_by(user: current_user)
      if @user.nil?
        @user = UserOnline.create(active: true, status: "In a call", user: current_user)
      else
        @user.status = "In a Call"
        @user.save
      end
    end
  end

  def update
    authorize @opencall
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

  def call_id_find
    @opencall = OpenCall.find(params[:id])
  end

  def open_params
    params.require(:open_call).permit(:first_name, :case_no, :last_name, :address, :address2, :city, :state, :zip, :telephone_no, :email, :product_id, :serial_number, :symptom, :status)
  end
end
