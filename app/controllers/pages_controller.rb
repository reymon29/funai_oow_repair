class PagesController < ApplicationController

  def home
    @order = Order.new
    @product_model = Product.order(:model_no)
    @pending_shipping = Order.where(bap_ship: true)
  end
end
