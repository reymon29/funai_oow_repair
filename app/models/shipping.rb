class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :shipout_courier, inclusion: { in: %w(FedEx UPS USPS DHL) }
  # mount_uploader :label, ShippingUploader

  def shipstation_create_return(order)
    require 'rubygems' if RUBY_VERSION < '1.9'
    require 'rest_client'
    require 'json'
    require "base64"

    values = '{
      "carrierCode": "fedex",
      "serviceCode": "fedex_ground",
      "packageCode": "package",
      "confirmation": "delivery",
      "shipDate": "#{Time.new.strftime("%Y-%m-%d")}",
      "weight": {
        "value": 15,
        "units": "pounds"
      },
      "dimensions": {
        "units": "inches",
        "length": 13.5,
        "width": 9,
        "height": 12
      },
      "shipFrom": {
        "name": "#{order.first_name} #{order.last_name}",
        "company": "",
        "street1": "#{order.address}",
        "street2": "#{order.address2}",
        "street3": null,
        "city": "#{order.city}",
        "state": "#{order.state}",
        "postalCode": "#{order.zip}",
        "country": "US",
        "phone": "#{order.telephone_no}",
        "residential": false
      },
      "shipTo": {
        "name": "Nancy Hart-DVD OOW",
        "company": "Funai Service Corporation",
        "street1": "2425 Spiegel Dr",
        "street2": "",
        "street3": null,
        "city": "Groveport",
        "state": "OH",
        "postalCode": "43125",
        "country": "US",
        "phone": "8552896373",
        "residential": false
      },
      "insuranceOptions": null,
      "internationalOptions": null,
      "advancedOptions": null,
      "testLabel": false,
      "customField1": "DVD OOW",
      "storeId": "Funai OOW",
      "customField2": "#{order.case_no}"
    }'

    headers = {
      :content_type => 'application/json',
      :authorization => ENV['SHIPSTATION_BASIC']
    }

    response = RestClient.post 'https://ssapi.shipstation.com/shipments/createlabel', values, headers
    response = JSON.parse(response)
    label = response['labelData']
    File.open('shipping_label.pdf', "wb") do |f|
      f.write(Base64.decode64(label))
    end
  end
end
