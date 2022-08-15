# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'super@admin.com', password: '1234567', password_confirmation: '1234567')
User.create!(email: 'admin@admin.com', password: '1234567', password_confirmation: '1234567', role: 'admin')
User.create!(email: 'customer@customer.com', password: '1234567', password_confirmation: '1234567', role: 'customer')
User.create!(email: 'customer@again.com', password: '1234567', password_confirmation: '1234567', role: 'customer')

Category.create!(name: 'Rice')
Category.create!(name: 'Soup')
Category.create!(name: 'Fries')
Category.create!(name: 'Desi')
Category.create!(name: 'Chinese')

Item.create!(title: 'Fried Rice', description: 'Egg, Vegetables, Chicken', price: 350.0)
Item.create!(title: 'Chicken Makhni', description: 'Chicken, Desi, Karahi', price: 1200.0)
Item.create!(title: 'Masala Fries', description: 'Traditional, Spicies', price: 150.0)
Item.create!(title: 'Chicken Biryani', description: 'Desi Style, Spicies', price: 400.0)
Item.create!(title: 'Chicken Soup', description: 'Egg, Corn, Chicken', price: 250.0)
Item.create!(title: 'Noddle Soup', description: 'Noddles, Chicken, Spicy', price: 600.0)
Item.create!(title: 'Garlic Fries', description: 'Special Garlic Sauce', price: 300.0)
Item.create!(title: 'Sushi', description: 'Chinese Special Dish', price: 2000.0)
Item.create!(title: 'Beef Kabab', description: 'Grilled in Smoke', price: 500.0)


