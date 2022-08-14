class CartController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    if current_user

      @order = current_user.orders.find_by status: '0'
      @order_items = @order.order_items
      session[:order_id] = @order.id

    else
      @order = Order.find_by(session[:order_id])
    end
  end

end
