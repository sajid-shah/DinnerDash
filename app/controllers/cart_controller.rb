class CartController < ApplicationController
  before_action :set_order
  before_action :authenticate_user!, only: %i[checkout]

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

  def checkout
    @order[:status] = 'ordered' if @order
    @order&.save
    redirect_to cart_path
  end

  private

  def set_order
    if current_user
      @order = current_user.orders.where(status: 'processing').empty? ? Order.find_by_id(session[:order_id]) : current_user.orders.where(status: 'processing')[0]
      @order[:user_id] = current_user.id unless @order.nil?
      @order&.save
      unless session[:order_id].nil?
        order_session = Order.find(session[:order_id])
        order_items_session = order_session.order_items
        session[:order_id] = nil
        order_user = current_user.orders.where(status: 'processing')
        order_items_user = order_user[0].order_items
        order_items = order_items_session + order_items_user
        # current_user.orders[0].order_items = order_items
        # current_user.orders[0].save
        @order.order_items = order_items
        @order.save
      end
    else
      @order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
    end
  end
end
