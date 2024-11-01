class AddPriceToPackages < ActiveRecord::Migration[7.2]
  def change
    add_column :packages, :price, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
