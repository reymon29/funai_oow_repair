class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.label.subject
  #
  def label
    @order = params[:order]

    mail(to: @order.email, subject: "Thank you for the order this is your return label.")
  end
end
