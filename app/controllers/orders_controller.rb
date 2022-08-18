class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.role == 'customer'
      @orders = current_user.orders.all#.where(status: 'ordered')
    else
      @orders = Order.all.where.user_id?
    end
  end

  def update
  end

  def create


  end
end
