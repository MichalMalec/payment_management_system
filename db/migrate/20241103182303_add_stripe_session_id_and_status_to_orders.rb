class AddStripeSessionIdAndStatusToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :stripe_session_id, :string
    add_column :orders, :status, :string
  end
end
