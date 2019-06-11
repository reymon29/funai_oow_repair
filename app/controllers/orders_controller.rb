class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :new]
  before_action :order_id_find, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def show
    @note = Note.new
    @repair = Repair.new
  end

  def new
    if opencall_id_find.nil?
      @order = Order.new
      @product_model = Product.order(:model_no)
    else
      @opencall = opencall_id_find
      @order = Order.new(case_no: @opencall.case_no, first_name: @opencall.first_name, last_name: @opencall.last_name, product: @opencall.product, serial_number: @opencall.serial_number, symptom: @opencall.symptom, address: @opencall.address, address2: @opencall.address2, city: @opencall.city, state: @opencall.state, zip: @opencall.zip, telephone_no: @opencall.telephone_no, email: @opencall.email)
      @product_model = Product.order(:model_no)
    end
  end

  def create
    @product_model = Product.order(:model_no)
    @order = Order.new(order_params)
    @order_item = OrderItem.new
    @repair = RepairRate.find(1)
    @order.user = current_user
    @notes = Note.new
    @notes.comment = "Created order request"
    @notes.user = user_signed_in? ? current_user : User.find_by_id(2)
    @order.order_status = "Order Created"
    @order.amount = @repair.price
    if @order.save
      @notes.order = @order
      @notes.save
      @order_item.order = @order
      @order_item.repair_rate = @repair
      @order_item.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit
    @product_model = Product.order(:model_no)
    @note = Note.new
  end

  def update
    @product_model = Product.order(:model_no)
    @order.update(order_params)
    redirect_to order_path(@order)
  end

  private

  def order_id_find
    @order = Order.find(params[:id])
  end

  def opencall_id_find
    if params[:open_call_id].nil?
    else
      @opencall = OpenCall.find(params[:open_call_id])
    end
  end

  def order_params
    params.require(:order).permit(:first_name, :case_no, :last_name, :address, :address2, :city, :state, :zip, :telephone_no, :email, :product_id, :serial_number, :symptom, :order_status, :notes)
  end

end
