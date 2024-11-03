class SubscriptionsController < ApplicationController
  def new
    @packages = Package.all
  end
end
