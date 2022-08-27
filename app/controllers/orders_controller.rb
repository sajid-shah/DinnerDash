# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_order, only: %i[update destroy]

  def index
    authorize Order
    @orders = case current_user.role
              when 'customer'
                customer_orders
              when 'admin'
                admin_orders
              else
                superadmin_orders
              end
  end

  def change_status
    authorize Order
    order = Order.find(params[:id])
    order.status = params[:status]
    flash[:notice] = order.save ? t(:order_status) : order.errors.full_messages
    redirect_to orders_index_path
  end

  def update
    authorize Order
  end

  def show
    authorize Order
    @order_items = Order.find(params[:id]).order_items
  end

  def create
    authorize Order
  end

  def destroy
    authorize Order
    flash[:alert] = @order.destroy ? t(:cart_cleared) : @order.errors.full_messages
    session[:order_id] = nil

    redirect_to cart_path
  end

  private

  def set_order
    if current_user
      current_order
      @order = current_user.orders.create if @order.nil?
    elsif session[:order_id]
      @order = Order.find_by(id: session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
  end

  def customer_orders
    current_user.orders.all
  end

  def superadmin_orders
    params[:status] ? Order.where(status: params[:status]) : Order.where.not(status: 'processing')
  end

  def admin_orders
    if params[:status]
      admin_orders_params
    else
      admin_orders_without_params
    end
  end

  def admin_orders_params
    Order.where(status: params[:status]).select do |x|
      current_user.restaurants.ids.include?(x.restaurant_id)
    end
  end

  def admin_orders_without_params
    Order.where.not(status: 'processing').select do |x|
      current_user.restaurants.ids.include?(x.restaurant_id)
    end
  end

  def current_order
    @order = current_user.orders.where(status: 'processing').first
  end
end
