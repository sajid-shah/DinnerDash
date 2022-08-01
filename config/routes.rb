# frozen_string_literal: true

Rails.application.routes.draw do
  get 'items/index'
  get 'items/show'
  get 'items/update'
  get 'items/destroy'
  get 'items/edit'
  get 'items/new'
  get 'items/create'
  devise_for :users
  resources :items
  get 'home/index'
  root 'home#index'
  get 'home/about'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
