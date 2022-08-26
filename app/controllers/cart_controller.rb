# frozen_string_literal: true

class CartController < ApplicationController
  before_action :set_order
  before_action :authenticate_user!, only: %i[checkout]

  def index
    authorize self
    @order_items = @order.order_items unless @order.nil?
  end

  def checkout
    authorize self
    @order[:status] = 'ordered' if @order
    @order&.save ? flash[:notice] = t(:ordered_successfully) : flash[:alert] = t(:please_add_items_in_cart)

    redirect_to cart_path
  end

  private

  def set_order
    if current_user
      @order = current_user.orders.where(status: 'processing').empty? ? Order.find_by(id: session[:order_id]) : current_user.orders.where(status: 'processing').first
      @order[:user_id] = current_user.id unless @order.nil?
      @order&.save
      find_session(@order)
    else
      @order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
    end
  end

  def find_session(order_instance)
    return if session[:order_id].nil?

    order_session = Order.find(session[:order_id])
    order_items_session = order_session.order_items
    session[:order_id] = nil
    order_user = current_user.orders.where(status: 'processing')
    order_items_user = order_user[0].order_items
    order_items = order_items_session + order_items_user
    order_instance.order_items = order_items
    order_instance.save
  end
end
