class AddStripeProductIdToPackages < ActiveRecord::Migration[7.2]
  def change
    add_column :packages, :stripe_product_id, :string
  end
end
