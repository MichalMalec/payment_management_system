class Order < ApplicationRecord
  belongs_to :user
  belongs_to :package

  validates :order_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }
end
