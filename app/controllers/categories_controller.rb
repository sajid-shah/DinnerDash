# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @categories = Category.all
  end

  def show
    authorize Category
  end

  def update
    authorize Category
    if @category.update(category_params)
      flash[:notice] = t(:category_updated)
    else
      flash[:alert] = @category.errors.full_messages
    end

    redirect_to categories_path
  end

  def destroy
    authorize Category
    flash[:alert] = @category.destroy ? t(:category_deleted) : @category.errors.full_messages

    redirect_to categories_path
  end

  def new
    authorize Category
    @category = Category.new
  end

  def create
    authorize Category
    @category = Category.new(category_params)
    @category.save ? flash[:notice] = t(:category_created) : flash[:alert] = @category.errors.full_messages

    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
