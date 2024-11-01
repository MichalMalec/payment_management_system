class Order < ApplicationRecord
  belongs_to :user

  validates :order_date, presence: true
  validates :payment_status, presence: true, inclusion: { in: %w[unpaid paidb] }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
