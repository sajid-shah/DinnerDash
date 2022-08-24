class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_order, only: %i[update destroy]

  def index
    if current_user.role == 'customer'

      @orders = current_user.orders.all

    elsif current_user.role == 'admin'
      # @count = Order.where.not(status: 'processing').select{|x| current_user.restaurants.ids.include?(x.restaurant_id) }
      params[:status] ? @orders = Order.where(status: params[:status]).select{|x| current_user.restaurants.ids.include?(x.restaurant_id)} : @orders = Order.where.not(status: 'processing').select{|x| current_user.restaurants.ids.include?(x.restaurant_id) }
    else
      params[:status] ? @orders = Order.where(status: params[:status]) : @orders = Order.where.not(status: 'processing')
    end
  end

  def change_status
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to orders_index_path
  end


  def update
  end

  def show
    @order_items = Order.find(params[:id]).order_items

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
