class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @order = Order.new
    @product_model = Product.order(:model_no)
  end
end
