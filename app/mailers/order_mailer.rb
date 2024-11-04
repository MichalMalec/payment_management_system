class OrderMailer < ApplicationMailer
  # sender email
  default from: "no-reply@payments-system.com"

  def payment_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: "Payment confirmation")
  end
end
