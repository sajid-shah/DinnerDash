# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[index]

  def toggle_status
    authorize Item
    item = Item.find(params[:id])
    item.active = !item.active
    item.save && item.active ? flash[:notice] = t(:item_active) : flash[:alert] = t(:item_retire)

    redirect_to items_path
  end

  def index
    @items = Item.all
    if current_user && current_user.role == 'admin'
      @items = Item.select do |x|
        current_user.restaurants.ids.include?(x.restaurant_id)
      end
    end

    @items = Category.find_by(id: params[:category_id]).items if params[:category_id]
    @items = Restaurant.find_by(id: params[:restaurant_id]).items if params[:restaurant_id]

    return unless params[:category_id] && current_user && current_user.role == 'admin'

    @items = Category.find_by(id: params[:category_id]).items.select do |x|
      current_user.restaurants.ids.include?(x.restaurant_id)
    end
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
    params.require(:item).permit(:restaurant_id, :id, :title, :description, :price, :active, category_ids: [])
  end
end
