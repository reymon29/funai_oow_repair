# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating Product List"
Product.create(brand: "Magnavox", model_no: "MDR865H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
Product.create(brand: "Magnavox", model_no: "MDR867H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
Product.create(brand: "Magnavox", model_no: "MDR868H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
Product.create(brand: "Funai", model_no: "ZV427FX4", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
Product.create(brand: "Funai", model_no: "ZV427FX4 A", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
Product.create(brand: "Emerson", model_no: "ZV427EM5", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
Product.create(brand: "Sanyo", model_no: "FWZV475F", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
puts "Finishing list"


puts "Create Users"
User.create(email: "HGSTEAM@HGS.com", password: "HGSTEAM@121", first_name: "HGS", last_name: "TEAM", dept: "Call Center", location: "Remote")
User.create(email: "rmontemayor@funaiservice.com", password: "123456", first_name: "Reyes", last_name: "Montemayor", dept: "Call Center", location: "Remote")
puts "Finishing"
