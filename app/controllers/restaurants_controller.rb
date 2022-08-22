class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @restaurants = Restaurant.all
    if current_user
      @restaurants = current_user.restaurants if current_user.role == 'admin'
    end
  end

  def show
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  def edit
    @restaurant.updated
    @restaurant.save
    redirect_to restaurants_path
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params.merge!(user_id: current_user.id))
    @restaurant.save
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
