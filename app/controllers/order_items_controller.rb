class OrderItemsController < ApplicationController
  before_action :set_order
  # before_action :set_total
  after_action  :set_total
  def index
    @order_items = Order_Items.find_by(params[:order_id])
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(order_item_params)
    @order_items = @order.order_items
    redirect_to cart_index_path

  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_index_path
  end

  def create

    # if !current_user
    #   if (session[:order_id])
    #     @order=Order.find_by(id: session[:order_id])
    #   else
    #     @order = Order.create
    #     session[:order_id] = @order.id
    #   end
    # else
    #   @orders = current_user.orders
    #   if @orders.empty?
    #     @order = current_user.orders.create
    #   end
    # end
    # byebug
    # if current_user
    #   # @user_order = Order.where(status:'processing').find_by(user_id: current_user.id)
    #   @order = Order.where(status:'processing').find_by(user_id: current_user.id)

    # else
    #   # @user_order = Order.find_by(id: session[:order_id])
    # end
    @order_item = @order.order_items.create(order_item_params)
    # @order_item = @user_order.order_items.create(order_item_params)









    redirect_to items_path
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

  def order_item_params
    params.require(:order_item).permit(:item_id, :quantity)
  end

  def set_total
    @order[:total] = @order.order_items.sum{ |order_item| order_item.valid? ? order_item.quantity * order_item.unit_price : 0.0 }
    @order&.save
  end

  # def current_order
  #   if Order.find_by_id(session[:order_id]).nil?
  #     order = Order.new
  #     session[:order_id] = order.id
  #   else
  #     Order.find_by_id(session[:order_id])
  #   end
  # end
end
