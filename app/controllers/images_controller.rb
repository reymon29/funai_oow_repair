class ImagesController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    @images = @order.images.build
  end

  def create
    if params[:images]
      params[:images].each do |image|
      @order.images.create(image: image)
      end
    end
    redirect_to order_path(@order)
  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def images_params
    params.require(:return).permit(images_attributes: [:image, :order_id])
  end
end

