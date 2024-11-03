# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.create(name: "John Doe", email: "john.doe@example.com")
user2 = User.create(name: "Jane Smith", email: "jane.smith@example.com")
user3 = User.create(name: "Admin User", email: "admin@example.com")

basic_package = Package.create(name: "Basic", price: 10.00, stripe_price_id: "price_1QDXrP2MhlPejvlascFIbX3A")
pro_package = Package.create(name: "Pro", price: 50.00, stripe_price_id: "price_1QDXrw2MhlPejvlaw1u4Fqfd")
enterprise_package = Package.create(name: "Enterprise", price: 500.00, stripe_price_id: "price_1QDXt02MhlPejvlauawSOvU2")

Order.create(order_date: Time.now, user_id: user1.id, payment_status: "paid", total_amount: basic_package.price, package_id: basic_package.id, status: "pending")
Order.create(order_date: Time.now - 1.day, user_id: user1.id, payment_status: "unpaid", total_amount: pro_package.price, package_id: pro_package.id, status: "pending")
Order.create(order_date: Time.now - 2.days, user_id: user2.id, payment_status: "paid", total_amount: enterprise_package.price, package_id: enterprise_package.id, status: "pending")
Order.create(order_date: Time.now - 3.days, user_id: user3.id, payment_status: "unpaid", total_amount: basic_package.price, package_id: basic_package.id, status: "pending")
