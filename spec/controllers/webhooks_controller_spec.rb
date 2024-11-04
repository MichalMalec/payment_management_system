require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do
  describe "POST #receive" do
  let(:user) { create(:user) }
  let(:package) { create(:package) }
  let!(:order) { create(:order, user: user, package: package, status: "pending", stripe_session_id: "test_session_id") }
    context "when checkout.session.completed event is received" do
      before do
        payload = {
          id: "evt_test_id",
          object: "event",
          type: "checkout.session.completed",
          data: {
            object: {
              id: "test_session_id" # has to be the same as stripe_session_id in event
            }
          }
        }.to_json
        request.headers["HTTP_STRIPE_SIGNATURE"] = "test_signature"

        allow(Stripe::Webhook).to receive(:construct_event).and_return(JSON.parse(payload))

        post :receive, body: payload
      end


      it "updates the order status to completed" do
        expect(order.reload.status).to eq("completed")
      end
    end

    context 'when the invoice payment fails' do
        before do
          payload = {
            id: "evt_test_id",
            object: "event",
            type: "invoice.payment_failed",
            data: {
              object: {
                id: "test_session_id"
              }
            }
          }.to_json

          request.headers["HTTP_STRIPE_SIGNATURE"] = "test_signature"

          allow(Stripe::Webhook).to receive(:construct_event).and_return(JSON.parse(payload))

          post :receive, body: payload
        end

        it 'updates the order status to failed' do
          order.reload
          expect(order.status).to eq("failed")
        end
      end
  end
end
