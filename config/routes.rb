# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  resources :items
  resources :categorizations

  get 'home/index'
  root 'items#index'
  get 'home/about'

  devise_scope :user do
    get 'users/registrations/index' => 'users/registrations#index'
    post 'users/registrations/make_admin' => 'users/registrations#make_admin'
  end

  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                            passwords: 'users/passwords' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
