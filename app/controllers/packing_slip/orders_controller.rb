module PackingSlip
  class OrdersController < ApplicationController

    def show
      authorize @order
      @order = Order.find(params[:id])
      respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Invoice No. #{@order.id}",
                page_size: 'A4',
                template: "packing_slip/orders/show.html.erb",
                layout: "pdf.html",
                orientation: "Landscape",
                lowquality: true,
                zoom: 1,
                dpi: 75
        end
      end
    end
  end
end
