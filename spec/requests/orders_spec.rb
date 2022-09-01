# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /orders when User Signed In as' do
    let!(:superadmin) { create(:superadmin_user) }
    let!(:customer) { create(:customer_user) }
    let!(:customer_order) { create(:order, user_id: customer.id) }
    let!(:admin) { create(:admin_user) }
    let!(:admin_restaurant) { create(:restaurant, user_id: admin.id) }
    let!(:order) do
      create(:order, restaurant_id: admin_restaurant.id, user_id: customer.id, status: 'ordered')
    end
    let!(:order_item) { create(:order_item, order_id: order.id) }

    it "customer, index customer's order" do
      sign_in customer

      get orders_path
      expect(response).to have_http_status(:ok)
      expect(assigns[:orders]).to eq(customer.orders)
    end

    it 'admin, index admins order' do
      sign_in admin
      get orders_url(status: 'ordered'), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
      get orders_path
      expect(response).to have_http_status(:ok)
      expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'superadmin, index superadmin order' do
      sign_in superadmin

      # get orders_path
      get orders_url(status: 'ordered'), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:orders]).to eq(customer.orders.where(status: 'ordered'))
    end

    it 'admin, change order status' do
      sign_in admin
      post orders_change_status_url(status: 'paid', id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_].status).to eq('paid')
      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'superadmin, change order status' do
      sign_in superadmin
      post orders_change_status_url(status: 'completed', id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_].status).to eq('completed')

      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'as customer, cannot change order status' do
      sign_in customer
      post orders_change_status_url(status: 'paid', id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_]).to be_falsy

      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'as customer, can show order' do
      sign_in customer
      get order_url(id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_items].first).to eq(order.order_items.first)

      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'as admin, can show order' do
      sign_in admin
      get order_url(id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_items].first).to eq(order.order_items.first)

      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    it 'as superadmin, can show order' do
      sign_in customer
      get order_url(id: order.id), xhr: true
      expect(response).to have_http_status(:ok)
      expect(assigns[:order_items].first).to eq(order.order_items.first)

      # get orders_path
      # expect(response).to have_http_status(200)
      # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    end

    # it "as admin, can delete order" do
    #   sign_in admin
    #   delete order_url(:order), xhr: true
    #   expect(response).to have_http_status(200)
    #   expect(assigns[:order]).to be_falsy

    #   # get orders_path
    #   # expect(response).to have_http_status(200)
    #   # expect(assigns[:orders].first).to eq(admin.restaurants.first.orders.first)
    # end
  end
end
