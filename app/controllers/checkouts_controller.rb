class CheckoutsController < ApplicationController
  def create
    # tbd
    user = User.first

    package = Package.find_by(name: params[:plan])

    unless package
      render json: { error: "Incorrect plan" }, status: :unprocessable_entity
      return
    end

    # Create session Stripe Checkout
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price: package.stripe_price_id,
        quantity: 1
      } ],
      mode: "subscription",
      success_url: root_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url
    )

    # Create order in db
    order = user.orders.create(
      order_date: Time.now,
      user_id: user.id,
      total_amount: package.price,
      package: package,
      stripe_session_id: session.id,
      status: "pending"
    )

    # send email if order was saved
    if order.persisted?
      OrderMailer.payment_confirmation(order).deliver_now
    end

    render json: { id: session.id }
  end
end
