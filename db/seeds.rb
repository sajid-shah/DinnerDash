# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'super@admin.com', password: '1234567', password_confirmation: '1234567')
User.create!(email: 'admin@admin.com', password: '1234567', password_confirmation: '1234567')
User.create!(email: 'customer@customer.com', password: '1234567', password_confirmation: '1234567', role: 'customer')
User.create!(email: 'customer@again.com', password: '1234567', password_confirmation: '1234567', role: 'customer')

Category.create!(name: 'Asian')
Category.create!(name: 'Soup')
Category.create!(name: 'Chinese')
Category.create!(name: 'Fast Food')
Category.create!(name: 'Japanese')


Restaurant.create!(name: 'Kabul', user_id: 1)
Restaurant.create!(name: 'KFC', user_id: 1)
Restaurant.create!(name: 'OPTP', user_id: 1)
Restaurant.create!(name: 'Mei Kong', user_id: 2)
Restaurant.create!(name: 'The Thai', user_id: 2)



Item.create!(title: 'Fried Rice', description: 'Egg, Vegetables, Chicken', price: 350.0, restaurant_id: 1)
Item.create!(title: 'Chicken Makhni', description: 'Chicken, Desi, Karahi', price: 1200.0, restaurant_id: 1)
Item.create!(title: 'Masala Fries', description: 'Traditional, Spicies', price: 150.0, restaurant_id: 3)
Item.create!(title: 'Chicken Biryani', description: 'Desi Style, Spicies', price: 400.0, restaurant_id: 1)
Item.create!(title: 'Chicken Soup', description: 'Egg, Corn, Chicken', price: 250.0, restaurant_id: 4)
Item.create!(title: 'Noddle Soup', description: 'Noddles, Chicken, Spicy', price: 600.0, restaurant_id: 4)
Item.create!(title: 'Garlic Fries', description: 'Special Garlic Sauce', price: 300.0, restaurant_id: 3)
Item.create!(title: 'Sushi', description: 'Chinese Special Dish', price: 2000.0, restaurant_id: 5)
Item.create!(title: 'Beef Kabab', description: 'Grilled in Smoke', price: 500.0, restaurant_id: 1)
Item.create!(title: 'Prawns Soup', description: 'In Tradition Style', price: 350.0, restaurant_id: 4)
Item.create!(title: 'Chicken Zinger Burger', description: 'Chicken, Single Patte', price: 1200.0, restaurant_id: 2)
Item.create!(title: 'Masala Garlic Mayo Fries', description: 'Spicies, Special Mayo', price: 150.0, restaurant_id: 3)
Item.create!(title: 'Thai Pasta', description: 'Vegetables, Japanese Style', price: 400.0, restaurant_id: 5)
Item.create!(title: 'Thai Soup', description: 'Egg, Corn, Chicken', price: 250.0, restaurant_id: 5)
Item.create!(title: 'Corn Soup', description: 'Corns, Eggs, Spicy', price: 600.0, restaurant_id: 4)
Item.create!(title: 'Sea Fish', description: 'Smoked Fish, Japanese Sauce', price: 300.0, restaurant_id: 5)
Item.create!(title: 'Thai Special Sushi', description: 'Thai Special', price: 2000.0, restaurant_id: 5)
Item.create!(title: 'Regular KFC Fries', description: 'with KFC sauce', price: 500.0, restaurant_id: 2)


Categorization.create!(item_id: 1, category_id: 1)
Categorization.create!(item_id: 2, category_id: 1)
Categorization.create!(item_id: 3, category_id: 4)
Categorization.create!(item_id: 4, category_id: 1)
Categorization.create!(item_id: 5, category_id: 3)
Categorization.create!(item_id: 6, category_id: 3)
Categorization.create!(item_id: 7, category_id: 4)
Categorization.create!(item_id: 8, category_id: 5)
Categorization.create!(item_id: 9, category_id: 1)
Categorization.create!(item_id: 10, category_id: 5)
Categorization.create!(item_id: 11, category_id: 4)
Categorization.create!(item_id: 12, category_id: 4)
Categorization.create!(item_id: 13, category_id: 5)
Categorization.create!(item_id: 14, category_id: 5)
Categorization.create!(item_id: 15, category_id: 3)
Categorization.create!(item_id: 16, category_id: 5)
Categorization.create!(item_id: 17, category_id: 5)
Categorization.create!(item_id: 18, category_id: 4)
Categorization.create!(item_id: 5, category_id: 2)
Categorization.create!(item_id: 6, category_id: 2)
Categorization.create!(item_id: 15, category_id: 2)
Categorization.create!(item_id: 14, category_id: 2)
