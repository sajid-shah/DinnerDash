# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderItems', type: :request do
  let!(:customer) { create(:customer_user) }

  context 'when User Signed In as Customer' do
    describe 'Update OrderItem in Cart' do
      let!(:customer) { create(:customer_user) }
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id, user_id: customer.id)
      end
      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      let!(:order_item) { create(:order_item, order_id: order.id, item_id: item.id) }

      before do
        sign_in customer
      end

      it 'Update OrderItem with Valid Quantity in Cart' do
        patch order_item_url(id: order_item.id), params: { order_item: { quantity: 20, item_id: order_item.item_id } },
                                                 xhr: true
        expect(assigns[:order_item].quantity).to eq(20)
        expect(flash[:notice]).to eq('Cart Updated Successfully.')
      end

      it 'Update OrderItem with InValid Quantity in Cart' do
        patch order_item_url(id: order_item.id), params: { order_item: { quantity: -20, item_id: order_item.item_id } },
                                                 xhr: true
        expect(assigns[:order_item].errors.full_messages).to include('Quantity must be greater than 0')
      end

      it 'Successfully remove Item from Cart' do
        delete order_item_url(order_item.id), xhr: true
        expect(OrderItem.find_by(id: order_item.id)).to be_nil
        expect(response).to be_successful
        expect(flash[:alert]).to eq('Item Removed from Cart.')
      end
    end

    describe 'Add Items to Cart of same Restaurant' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id, user_id: customer.id)
      end
      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      let!(:order_item) { create(:order_item, order_id: order.id, item_id: item.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }
      let!(:another_item) { create(:item, restaurant_id: restaurant.id) }
      let!(:another_order_item) { create(:order_item, order_id: order.id, item_id: another_item.id) }
      let!(:another_params) { { order_item: { quantity: 65, item_id: another_item.id, order_id: order.id } } }

      before do
        sign_in customer
      end

      it 'Add first order_item in cart' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add 2nd Item in Cart of same Restaurant' do
        post order_items_url, params: another_params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(another_params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(another_item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end
    end

    describe 'Add Items to Cart of different Restaurant' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id, user_id: customer.id)
      end

      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      # let!(:order_item) { create(:order_item, order_id: order.id, item_id: item.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }

      let!(:another_restaurant) { create(:restaurant) }
      let!(:another_item) { create(:item, restaurant_id: another_restaurant.id) }
      # let!(:another_order_item) { create(:order_item, order_id: order.id, item_id: another_item.id) }
      let!(:another_params) { { order_item: { quantity: 65, item_id: another_item.id, order_id: order.id } } }

      before do
        sign_in customer
      end

      it 'Add first order_item in cart' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add 2 items in Cart of Diff Restaurant' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')

        post order_items_url, params: another_params, xhr: true
        expect(flash[:alert]).to eq('Please Select Items from one Restaurant only!')
      end
    end

    describe 'Add Item in Cart' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id, user_id: customer.id)
      end
      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }
      let!(:invalid_params) { { order_item: { quantity: -55, item_id: item.id, order_id: order.id } } }

      before do
        sign_in customer
      end

      it 'Add Item with Valid Quantity' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add Item with InValid Quantity' do
        post order_items_url, params: invalid_params, xhr: true
        expect(assigns[:order_item].order_id).to eq(order.id)
        expect(assigns[:order_item].quantity).to eq(invalid_params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(assigns[:order_item].errors.full_messages).to include('Quantity must be greater than 0')
      end
    end
  end

  context 'when User Guest User' do
    describe 'Update OrderItem in Cart' do
      let!(:order_item) { create(:order_item) }

      before do
        sign_out customer
      end

      it 'Update OrderItem with Valid Quantity in Cart' do
        patch order_item_url(id: order_item.id), params: { order_item: { quantity: 100, item_id: order_item.item_id } },
                                                 xhr: true
        expect(assigns[:order_item].quantity).to eq(100)
        expect(flash[:notice]).to eq('Cart Updated Successfully.')
      end

      it 'Update OrderItem with InValid Quantity in Cart' do
        patch order_item_url(id: order_item.id), params: { order_item: { quantity: -100, item_id: order_item.item_id } },
                                                 xhr: true
        expect(assigns[:order_item].errors.full_messages).to include('Quantity must be greater than 0')
      end

      it 'Successfully remove Item from Cart' do
        delete order_item_url(order_item.id), xhr: true
        expect(OrderItem.find_by(id: order_item.id)).to be_nil
        expect(response).to be_successful
        expect(flash[:alert]).to eq('Item Removed from Cart.')
      end
    end

    describe 'Add Items to Cart of same Restaurant' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id)
      end
      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      let!(:order_item) { create(:order_item, order_id: order.id, item_id: item.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }

      let!(:another_item) { create(:item, restaurant_id: restaurant.id) }
      let!(:another_order_item) { create(:order_item, order_id: order.id, item_id: another_item.id) }
      let!(:another_params) { { order_item: { quantity: 65, item_id: another_item.id, order_id: order.id } } }

      before do
        sign_out customer
      end

      it 'Add first order_item in cart' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add 2nd Item in Cart of same Restaurant' do
        post order_items_url, params: another_params, xhr: true
        expect(assigns[:order_item].quantity).to eq(another_params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(another_item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end
    end

    describe 'Add Items to Cart of different Restaurant' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id)
      end

      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      # let!(:order_item) { create(:order_item, order_id: order.id, item_id: item.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }

      let!(:another_restaurant) { create(:restaurant) }
      let!(:another_item) { create(:item, restaurant_id: another_restaurant.id) }
      # let!(:another_order_item) { create(:order_item, order_id: order.id, item_id: another_item.id) }
      let!(:another_params) { { order_item: { quantity: 65, item_id: another_item.id, order_id: order.id } } }

      before do
        sign_out customer
      end

      it 'Add first order_item in cart' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add 2 items in Cart of Diff Restaurant' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')

        post order_items_url, params: another_params, xhr: true
        expect(flash[:alert]).to eq('Please Select Items from one Restaurant only!')
      end
    end

    describe 'Add Item in Cart' do
      let!(:restaurant) { create(:restaurant) }
      let!(:order) do
        create(:order, restaurant_id: restaurant.id)
      end
      let!(:item) { create(:item, restaurant_id: restaurant.id) }
      let!(:params) { { order_item: { quantity: 55, item_id: item.id, order_id: order.id } } }
      let!(:invalid_params) { { order_item: { quantity: -55, item_id: item.id, order_id: order.id } } }

      before do
        sign_out customer
      end

      it 'Add Item with Valid Quantity' do
        post order_items_url, params: params, xhr: true
        expect(assigns[:order_item].quantity).to eq(params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(flash[:notice]).to eq('Item Added to Cart.')
      end

      it 'Add Item with InValid Quantity' do
        post order_items_url, params: invalid_params, xhr: true
        expect(assigns[:order_item].quantity).to eq(invalid_params[:order_item][:quantity])
        expect(assigns[:order_item].item_id).to eq(item.id)
        expect(assigns[:order_item].errors.full_messages).to include('Quantity must be greater than 0')
      end
    end
  end
end
