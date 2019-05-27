class OrderMailer < ApplicationMailer
  before_action :add_inline_attachment!

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
  private

  def add_inline_attachment!
    attachments.inline["logo.png"] = File.read("app/assets/images/logo.png")
  end
end
