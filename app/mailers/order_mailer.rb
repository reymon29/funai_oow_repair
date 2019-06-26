class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.label.subject
  #
  def label
    @order = params[:order]
    @shipping = params[:shipping]
    mail(to: @order.email, subject: "🛠Thank you for the order " + @order.order_no.to_s + " "+ @order.product.model_no + " this is your shipping label.").attachments[@shipping + ".pdf"] = File.read('public/uploads/labels/'+ @shipping +'.pdf')
  end

  def invoice
    @order = params[:order]
    mail(to: @order.email, subject: "🛠Thank you for your payment order no. " + @order.order_no.to_s + " "+ @order.product.model_no + " copy of invoice.")
  end

  def repair_completed
    @order = params[:order]
    @shipping = params[:shipping]
    mail(to: @order.email, subject: "🛠Repair Completed order no. " + @order.order_no.to_s + " "+ @order.product.model_no + " shipping back.")
  end
end
