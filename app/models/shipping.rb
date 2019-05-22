class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :shipout_courier, inclusion: { in: %w(FedEx UPS USPS DHL) }
  # mount_uploader :label, ShippingUploader

  def self.shipstation(order)
    require 'rest-client'
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

    puts ""#{order.first_name}""
#     values = '{
#   "carrierCode": "fedex",
#   "serviceCode": "fedex_ground",
#   "packageCode": "package",
#   "confirmation": "delivery",
#   "shipDate": "2019-05-22",
#   "weight": {
#     "value": 3,
#     "units": "ounces"
#   },
#   "dimensions": {
#     "units": "inches",
#     "length": 7,
#     "width": 5,
#     "height": 6
#   },
#   "shipFrom": {
#     "name": "Jason Hodges",
#     "company": "ShipStation",
#     "street1": "2815 Exposition Blvd",
#     "street2": "Ste 2353242",
#     "street3": null,
#     "city": "Austin",
#     "state": "TX",
#     "postalCode": "78703",
#     "country": "US",
#     "phone": "1234567890",
#     "residential": false
#   },
#   "shipTo": {
#     "name": "The President",
#     "company": "US Govt",
#     "street1": "1600 Pennsylvania Ave",
#     "street2": "Oval Office",
#     "street3": null,
#     "city": "Washington",
#     "state": "DC",
#     "postalCode": "20500",
#     "country": "US",
#     "phone": "1234567890",
#     "residential": false
#   },
#   "insuranceOptions": null,
#   "internationalOptions": null,
#   "advancedOptions": null,
#   "testLabel": false
# }'
    # headers = {
    #   :content_type => 'application/json',
    #   :authorization => "Basic ZjJkNmE4NWQyNTNlNDM3MGFmN2UyNTQ5MzNjYTYxN2M6MzRiMmZiMWRlMGFlNGZiNjgxOTQ0ZmRhYjEyNzQ3OTc="
    # }

    # response = RestClient.post 'https://ssapi.shipstation.com/shipments/createlabel', values, headers
    # puts response
    # response = JSON.parse(response)
    # label = response['labelData']
    # File.open('shipping_label.pdf', "wb") do |f|
    #   f.write(Base64.decode64(label))
    # end
  end
end
