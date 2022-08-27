# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[index]

  def toggle_status
    authorize Item
    item = Item.find(params[:id])
    item.active = !item.active
    flash[:notice] = item.save && item.active ? t(:item_active) : t(:item_retire)

    redirect_to items_path
  end

  def index
    @items = Item.all
    admin_items
    category_items
    restaurant_items
    admin_params_items
  end

  def show
    authorize Item
  end

  def update
    authorize Item
    @item.update(item_params) ? flash[:notice] = t(:item_updated) : flash[:alert] = @item.errors.full_messages

    redirect_to @item.update(item_params) ? items_path : @item
  end

  def destroy
    authorize Item
    flash[:alert] = @item.destroy ? t(:item_deleted) : @item.errors

    redirect_to items_path
  end

  def new
    authorize Item
    @item = Item.new
  end

  def create
    authorize Item
    @item = Item.new(item_params)
    @item.save ? flash[:notice] = t(:item_created) : flash[:alert] = @item.errors.full_messages

    redirect_to @item.save ? items_path : new_item_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:restaurant_id, :id, :title, :description, :image, :price, :active, category_ids: [])
  end

  def admin_items
    return unless current_user && current_user.role == 'admin'

    @items = Item.select do |x|
      current_user.restaurants.ids.include?(x.restaurant_id)
    end
  end

  def category_items
    @items = Category.find_by(id: params[:category_id]).items if params[:category_id]
  end

  def restaurant_items
    @items = Restaurant.find_by(id: params[:restaurant_id]).items if params[:restaurant_id]
  end

  def admin_params_items
    return unless params[:category_id] && current_user && current_user.role == 'admin'

    @items = Category.find_by(id: params[:category_id]).items.select do |x|
      current_user.restaurants.ids.include?(x.restaurant_id)
    end
  end
end
