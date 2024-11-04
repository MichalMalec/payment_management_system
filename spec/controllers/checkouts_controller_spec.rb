require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:package) { create(:package) }

  describe "POST #create" do
    before do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(double(id: "session_123"))
    end

    context "when the plan is valid" do
      it "creates a checkout session and order" do
        post :create, params: { plan: package.name }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["id"]).to eq("session_123")

        order = user.orders.last
        expect(order).to be_present
        expect(order.total_amount).to eq(package.price)
        expect(order.status).to eq("pending")
      end

      it "sends a payment confirmation email" do
        expect {
          post :create, params: { plan: package.name }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the plan is invalid" do
      it "returns an error" do
        post :create, params: { plan: "Invalid Plan" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]).to eq("Incorrect plan")
      end
    end
  end
end
