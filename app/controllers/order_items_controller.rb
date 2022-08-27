# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order
  after_action :set_total, only: %i[update destroy]
  def index
    @order_items = Order_Items.find_by(params[:order_id])
  end

  def update
    authorize OrderItem
    @order_item = @order.order_items.find(params[:id])
    if @order_item.update(order_item_params)
      flash[:notice] =
        t(:cart_updated)
    else
      @order_item.errors.full_messages
    end
    redirect_to cart_path
  end

  def destroy
    authorize OrderItem
    @order_item = @order.order_items.find(params[:id])
    flash[:alert] = @order_item.destroy ? t(:item_removed) : @order_item.errors.full_messages

    redirect_to cart_path
  end

  def create
    authorize OrderItem
    @order_item = @order.order_items.new(order_item_params)
    if @order.order_items.length.zero? || @order_item.item.restaurant_id == current_order_item_restaurant
      save_order_item
    else
      flash[:alert] = t(:select_one_restaurant_at_a_time)
    end

    redirect_to items_path
  end

  private

  def set_order
    if current_user
      current_order
      @order = current_user.orders.create(restaurant_id: find_item_restaurant) if @order.nil?
    elsif session[:order_id]
      session_order
    else
      @order = Order.create(restaurant_id: find_item_restaurant)
      session[:order_id] = @order.id
    end
  end

  def order_item_params
    params.require(:order_item).permit(:item_id, :quantity)
  end

  def set_total
    @order[:total] = @order.order_items.sum do |order_item|
      order_item.valid? ? order_item.quantity * order_item.unit_price : 0.0
    end
    @order&.save
  end

  def find_item_restaurant
    Item.find(params[:order_item][:item_id]).restaurant_id
  end

  def current_order
    @order = current_user.orders.where(status: 'processing').first
  end

  def session_order
    @order = Order.find_by(id: session[:order_id])
  end

  def save_order_item
    flash[:notice] = @order_item.save ? t(:item_added) : @order_item.errors.full_messages
    set_total
  end

  def current_order_item_restaurant
    @order.order_items.first.item.restaurant_id
  end
end
