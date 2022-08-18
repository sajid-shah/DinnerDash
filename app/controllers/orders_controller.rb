class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_order, only: %i[update destroy]

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
  def destroy
    @order.destroy
    session[:order_id] = nil
    redirect_to cart_path
  end
  private

  def set_order
    if !current_user
      if session[:order_id]
        @order = Order.find_by(id: session[:order_id])
      else
        @order = Order.create
        session[:order_id] = @order.id
      end
    else
      @order = current_user.orders.where(status: 'processing')[0]
      if @order.nil?
        @order = current_user.orders.create
      end
    end

  end
end
