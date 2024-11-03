class HomeController < ApplicationController
  def index
    @orders = User.first.orders.order(created_at: :desc)
  end
end
