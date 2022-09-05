# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders Controller', type: :request do
  let!(:customer) { create(:customer_user) }
  let!(:admin) { create(:admin_user) }
  let!(:admin_restaurant) { create(:restaurant, user_id: admin.id) }
  let!(:order) do
    create(:order, restaurant_id: admin_restaurant.id, user_id: customer.id, status: 'ordered')
  end

  let!(:order_item) { create(:order_item, order_id: order.id) }

  context 'when User Signed In as Customer' do
    let!(:another_order) do
      create(:order, restaurant_id: admin_restaurant.id, user_id: customer.id, status: 'processing')
    end

    before do
      sign_in customer
    end

    it "Index Customer's order" do
      sign_in customer
      get orders_path
      expect(assigns[:orders]).to eq(customer.orders)
    end

    it 'Cannot Update Order Status' do
      post orders_change_status_url(status: 'paid', id: order.id), xhr: true
      expect(assigns[:order_]).to be_falsy
    end

    it 'Can remove all items from Cart' do
      delete order_url(another_order), xhr: true
      expect(Order.find_by(id: another_order.id)).to be_nil
      expect(response).to be_successful
      expect(flash[:alert]).to eq('Cart Cleared Successfully.')
    end

    it "Can show Order's Items" do
      get order_url(id: order.id), xhr: true
      expect(assigns[:order_items]).to eq(order.order_items)
    end

    it 'Cannot Show Order if it doesnot exist.' do
      get order_url(id: 302), xhr: true
      expect(flash[:alert]).to eq('Record not Found !')
    end
  end

  context 'when User Signed In as Admin' do
    let!(:admin) { create(:admin_user) }
    let!(:admin_restaurant) { create(:restaurant, user_id: admin.id) }
    let!(:order) do
      create(:order, restaurant_id: admin_restaurant.id, user_id: customer.id, status: 'ordered')
    end

    before do
      sign_in admin
    end

    it "Index Admin's Restaurant Orders" do
      get orders_path
      expect(assigns[:orders]).to eq(admin.restaurants.first.orders)
    end

    it 'Index All Processed Orders' do
      get orders_url(status: 'ordered'), xhr: true
      expect(assigns[:orders]).to eq(customer.orders.where(status: 'ordered'))
    end

    it 'Update Order Status' do
      post orders_change_status_url(status: 'paid', id: order.id), xhr: true
      expect(assigns[:order_].status).to eq('paid')
      expect(flash[:notice]).to eq('Order Status Changed Successfully!')
    end

    it "Can show Order's Items" do
      get order_url(id: order.id), xhr: true
      expect(assigns[:order_items]).to eq(order.order_items)
    end

    it 'Cannot Show Order if it doesnot exist.' do
      get order_url(id: 302), xhr: true
      expect(flash[:alert]).to eq('Record not Found !')
    end
  end

  context 'when User Signed In as Superadmin' do
    let!(:superadmin) { create(:superadmin_user) }

    before do
      sign_in superadmin
    end

    it 'Update Order Status' do
      post orders_change_status_url(status: 'completed', id: order.id), xhr: true
      expect(assigns[:order_].status).to eq('completed')
      expect(flash[:notice]).to eq('Order Status Changed Successfully!')
    end

    it 'Index All Processed Orders' do
      get orders_url(status: 'ordered'), xhr: true
      expect(assigns[:orders]).to eq(customer.orders.where(status: 'ordered'))
    end

    it "Can show Order's Items" do
      get order_url(id: order.id), xhr: true
      expect(assigns[:order_items]).to eq(order.order_items)
    end

    it 'Cannot Show Order if it doesnot exist.' do
      get order_url(id: 302), xhr: true
      expect(flash[:alert]).to eq('Record not Found !')
    end
  end
end
