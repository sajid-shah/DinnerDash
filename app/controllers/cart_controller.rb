class CartController < ApplicationController
  before_action :set_order
  def index

    # if current_user
    #   # @current_orders = current_user.orders.includes(:order_items).where(status: 'processing')
    #   @current_order = current_user.orders.where(status: 'processing')
    #   unless @current_order.empty?
    #     @order_items = @current_order[0].order_items
    #   end
    # else
    #   @current_order = Order.find_by(id: session[:order_id])
    #   if @current_order
    #     @order_items = @current_order.order_items
    #   end
    # end
    @order_items = @order.order_items unless @order.nil?
  end

  private

  def set_order
    if current_user
      @order = current_user.orders.where(status: 'processing')[0]
    else
      @order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
    end
  end
end
