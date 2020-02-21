class CreateSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :samples do |t|
      t.string :express_tracking
      t.string :original_net
      t.string :original_service
      t.string :ship_date
      t.string :original_delivery_name
      t.string :original_delivery_address
      t.string :original_delivery_city
      t.string :original_delivery_state
      t.string :original_delivery_zip
      t.string :original_delivery_country
      t.string :original_delivery_customer_reference
      t.string :original_delivery_customer_po
      t.string :original_delivery_customer_description
      t.string :original_delivery_main_rma
      t.string :original_delivery_main_name
      t.string :original_delivery_main_address
      t.string :original_delivery_main_city
      t.string :original_delivery_main_state
      t.string :original_delivery_main_country
      t.string :original_delivery_main_zip
      t.string :original_delivery_main_phone
      t.string :original_delivery_main_model
      t.string :original_delivery_main_model_size
      t.string :original_delivery_return_name
      t.string :original_delivery_return_address
      t.string :original_delivery_return_city
      t.string :original_delivery_return_state
      t.string :original_delivery_return_country
      t.string :original_delivery_return_zip
      t.string :original_delivery_return_net
      t.timestamps
    end
  end
end
