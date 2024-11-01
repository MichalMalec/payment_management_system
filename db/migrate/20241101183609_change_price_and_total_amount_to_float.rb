class ChangePriceAndTotalAmountToFloat < ActiveRecord::Migration[7.2]
  def change
    change_column :packages, :price, :float
    change_column :orders, :total_amount, :float
  end
end
