class NotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :new]
  before_action :order_id_find, only: [:new, :create]
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(notes_params)
    @note.order = @order
    @note.user = user_signed_in? ? current_user : User.find_by_id(2)
    if @note.save
      redirect_to order_path(@note.order)
    end
  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def notes_params
    params.require(:note).permit(:comment, :order_id)
  end
end
