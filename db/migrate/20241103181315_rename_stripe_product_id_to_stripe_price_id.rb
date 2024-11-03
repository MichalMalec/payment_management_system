class RenameStripeProductIdToStripePriceId < ActiveRecord::Migration[7.2]
  def change
    rename_column :packages, :stripe_product_id, :stripe_price_id
  end
end
