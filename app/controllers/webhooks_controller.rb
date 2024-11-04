class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def receive
      payload = request.body.read
      sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
      endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

      begin
        event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)

        case event["type"]
        when "checkout.session.completed"
          handle_successful_payment(event["data"]["object"])
        when "invoice.payment_failed"
          handle_failed_payment(event["data"]["object"])
        end

        render json: { message: "Received" }, status: :ok
      rescue JSON::ParserError => e
        render json: { error: "Invalid payload" }, status: :bad_request
      rescue Stripe::SignatureVerificationError => e
        render json: { error: "Invalid signature" }, status: :bad_request
      end
    end

    private

    def handle_successful_payment(session)
      order = Order.find_by(stripe_session_id: session['id'])
      return unless order

      order.update(status: "completed")

      # tbd
      OrderMailer.payment_confirmation(order).deliver_later
    end

    def handle_failed_payment(invoice)
      order = Order.find_by(stripe_invoice_id: invoice.id)
      return unless order

      order.update(status: "failed")
    end
end
