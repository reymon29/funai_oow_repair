# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# puts 'Cleaning database...'
# Note.destroy_all
# Receiving.destroy_all
# Order.destroy_all
# Product.destroy_all
# User.destroy_all
# User.destroy_all
# RepairRate.destroy_all
# puts 'Deleted database...'

# puts "Creating Product List"
# Product.create(brand: "Magnavox", model_no: "MDR865H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
# Product.create(brand: "Magnavox", model_no: "MDR867H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
# Product.create(brand: "Magnavox", model_no: "MDR868H/F7", product_type: "DVD/HDD", weight: 10.5, length: 20.5, width: 5.8, height: 16.3)
# Product.create(brand: "Funai", model_no: "ZV427FX4", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
# Product.create(brand: "Funai", model_no: "ZV427FX4 A", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
# Product.create(brand: "Emerson", model_no: "ZV427EM5", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
# Product.create(brand: "Sanyo", model_no: "FWZV475F", product_type: "DVD/VCR", weight: 13.5, length: 21.4, width: 7.1, height: 14.8)
# puts "Finishing list"


# puts "Create Users"
# User.create(email: "HGSTEAM@HGS.com", password: "HGSTEAM@121", first_name: "HGS", last_name: "TEAM", dept: "Call Center", location: "Remote")
# User.create(email: "rmontemayor@funaiservice.com", password: "123456", first_name: "Reyes", last_name: "Montemayor", dept: "Call Center", location: "Remote")
# puts "Finishing"

# puts "Create Repair Rates"
# RepairRate.create(category: "OOW", sku: "DVD001", name: "Diagnose Fee", price: 35)
# RepairRate.create(category: "Shipping", sku: "SHIP001", name: "Return Label Fee", price: 20)
# RepairRate.create(category: "Shipping", sku: "SHIP002", name: "Shipback Fee", price: 20)
# RepairRate.create(category: "Shipping", sku: "SHIP003", name: "Return Box Fee", price: 30)
# RepairRate.create(category: "Shipping", sku: "SHIP004", name: "Shelf Ship", price: 0)
# RepairRate.create(category: "Repair", sku: "REPAIR001", name: "Minor Repair Fee", price: 66)
# RepairRate.create(category: "Repair", sku: "REPAIR002", name: "Major Repair Fee", price: 90)
# RepairRate.create(category: "Repair", sku: "REPAIR003", name: "Non-repairable Fee", price: 0)
# puts "Finished"

puts "Create Master Model List"

filename = File.join Rails.root, "/db/2019_fedex_sample.csv"
CSV.foreach(filename, headers: true) do |row|
  rates = Sample.create(express_tracking: row[4],
    original_net: row[5],
    original_service: row[6],
    ship_date: row[7],
    original_delivery_name: "#{row[8]} #{row[9]}",
    original_delivery_address: row[10],
    original_delivery_city: row[11],
    original_delivery_state: row[12],
    original_delivery_zip: row[13],
    original_delivery_country: "US",original_delivery_customer_reference: row[15], original_delivery_customer_po: row[16], original_delivery_customer_description: row[17],original_delivery_main_rma: row[18], original_delivery_main_name: row[19], original_delivery_main_address: row[20], original_delivery_main_city: row[21],original_delivery_main_state: row[22], original_delivery_main_country: row[23], original_delivery_main_zip: row[24], original_delivery_main_phone: row[25], original_delivery_main_model: row[26], original_delivery_main_model_size: row[27], original_delivery_return_name: row[28], original_delivery_return_address: row[29], original_delivery_return_city: row[30], original_delivery_return_state: row[31], original_delivery_return_country: row[32], original_delivery_return_zip: row[33])
  puts "#{row[0]} - #{rates.errors.full_messages.join(",")}" if rates.errors.any?
end
