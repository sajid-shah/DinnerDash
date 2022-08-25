# frozen_string_literal: true

Rails.application.routes.draw do
  get '404' => 'application#page_not_found' if Rails.env.development?

  root 'items#index'
  get '/cart', to: 'cart#index'

  post 'items/:id', to: 'items#toggle_status'
  post 'cart' => 'cart#checkout'
  post 'orders/change_status' => 'orders#change_status'

  get 'orders/index'
  get 'orders/update'
  get 'orders/create'
  post 'orders', to: 'orders#destroy'

  resources :restaurants

  resources :restaurants do
    resources :items
  end

  resources :categories do
    resources :items
  end

  resources :categories
  resources :items
  resources :categorizations

  resources :orders
  resources :order_items

  devise_scope :user do
    get 'users/registrations/index' => 'users/registrations#index'
    post 'users/registrations/make_admin' => 'users/registrations#make_admin'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
