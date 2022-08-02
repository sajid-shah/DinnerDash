# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = Item.all
  end

  def show; end

  def update
    @item.update(item_params)

    # respond_to do |format|
    #   if @item.update(item_params)
    #     format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
    #     format.json { render :show, status: :ok, location: @item }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @item.destroy
  end

  def edit
    @item.update
    @item.save
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :description, :price, :active)
  end
end
