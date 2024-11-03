class CheckoutsController < ApplicationController
  def create
    Stripe.api_key = 'sk_test_51QCoES2MhlPejvla8Mwfu3YsFyAdX1B4I11kUNwJAnlxvcsZ2nikibCnbo6HmCLs0WxrEJdc53VSLecKfwCtMeUM00RsSsihlB'
    user = User.first

    package = Package.find_by(name: params[:plan])

    unless package
      render json: { error: 'Incorrect plan' }, status: :unprocessable_entity
      return
    end

    # Create session Stripe Checkout
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: package.stripe_price_id,
        quantity: 1
      }],
      mode: 'subscription',
      success_url: root_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url
    )

    # Create order in db
    order = user.orders.create(
      package: package,
      stripe_session_id: session.id,
      status: 'pending'
    )

    render json: { id: session.id }
  end
end
  