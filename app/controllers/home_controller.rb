class HomeController < ApplicationController
  def index
    #tbd
    @orders = User.first.orders.order(created_at: :desc)
  end
end
