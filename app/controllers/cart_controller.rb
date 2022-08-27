# frozen_string_literal: true

class CartController < ApplicationController
  before_action :set_order
  before_action :set_total, only: %i[checkout]
  before_action :authenticate_user!, only: %i[checkout]

  def index
    authorize self
    @order_items = @order.order_items unless @order.nil?
  end

  def checkout
    authorize self
    @order[:status] = 'ordered' unless @order.nil?
    @order&.save ? flash[:notice] = t(:ordered_successfully) : flash[:alert] = t(:please_add_items_in_cart)

    redirect_to items_path
  end

  private

  def set_order
    if current_user
      @order = current_user.orders.where(status: 'processing').empty? ? session_order : current_user_order
      save_order
      find_session(@order)
    else
      @order = session_order unless session[:order_id].nil?
    end
  end

  def find_session(order_instance)
    return if session[:order_id].nil?

    order_items_session = Order.find(session[:order_id]).order_items
    session[:order_id] = nil
    order_items_user = current_user_order_items
    order_items = order_items_session + order_items_user
    order_instance.order_items = order_items
    order_instance.save
  end

  def set_total
    return if @order.nil?

    @order[:total] = @order.order_items.sum do |order_item|
      order_item.valid? ? order_item.quantity * order_item.unit_price : 0.0
    end
    @order&.save
  end

  def current_user_order
    current_user.orders.where(status: 'processing').first
  end

  def current_user_order_items
    current_user.orders.where(status: 'processing').first.order_items
  end

  def session_order
    Order.find_by(id: session[:order_id])
  end

  def save_order
    @order[:user_id] = current_user.id unless @order.nil?
    @order&.save
  end
end
