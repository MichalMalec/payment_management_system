class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.references :user, null: false, foreign_key: true
      t.string :payment_status, default: "unpaid"
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
