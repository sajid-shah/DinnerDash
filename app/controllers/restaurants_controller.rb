# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @restaurants = Restaurant.all
    @restaurants = current_user.restaurants if current_user && current_user.role == 'admin'
  end

  def show
    authorize @restaurant
  end

  def destroy
    authorize Restaurant
    flash[:alert] = @restaurant.destroy ? t(:restaurant_deleted) : @restaurant.errors

    redirect_to restaurants_path
  end

  def edit
    authorize Restaurant
    @restaurant.updated
    @restaurant.save
    redirect_to restaurants_path
  end

  def update
    authorize Restaurant
    @restaurant.update(restaurant_params) ? flash[:notice] = t(:restaurant_updated) : flash[:alert] = @restaurant.errors

    redirect_to restaurants_path
  end

  def new
    authorize Restaurant
    @restaurant = Restaurant.new
  end

  def create
    authorize Restaurant
    @restaurant = Restaurant.new(restaurant_params.merge!(user_id: current_user.id))
    @restaurant.save ? flash[:notice] = t(:restaurant_created) : flash[:alert] = @restaurant.errors.full_messages

    redirect_to restaurants_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
