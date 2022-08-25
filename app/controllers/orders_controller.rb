# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_order, only: %i[update destroy]

  def index
    authorize Order
    @orders = case current_user.role
              when 'customer'

                current_user.orders.all

              when 'admin'
                if params[:status]
                  Order.where(status: params[:status]).select do |x|
                    current_user.restaurants.ids.include?(x.restaurant_id)
                  end
                else
                  Order.where.not(status: 'processing').select do |x|
                    current_user.restaurants.ids.include?(x.restaurant_id)
                  end
                end
              else
                params[:status] ? Order.where(status: params[:status]) : Order.where.not(status: 'processing')
              end
  end

  def change_status
    authorize Order
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save ? flash[:notice] = t(:order_status) : flash[:alert] = order.errors.full_messages
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
      @order = current_user.orders.where(status: 'processing').first
      @order = current_user.orders.create if @order.nil?
    elsif session[:order_id]
      @order = Order.find_by(id: session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
end
