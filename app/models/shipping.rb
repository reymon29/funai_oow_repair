class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
  mount_uploader :label, ShippingUploader

  def self.fedex_label(order, ship)
    shipping = Shipping.find(ship.id)
    require 'fedex'
    packages = []
    packages << {
      :weight => {:units => "LB", :value => 2},
      :dimensions => {:length => 10, :width => 5, :height => 4, :units => "IN" }
    }

    shipper = { :name => "#{order.first_name} #{order.last_name}",
                :company => "",
                :phone_number => order.telephone_no,
                :address => "#{order.address} #{order.address2}",
                :city => order.city,
                :state => order.state,
                :postal_code => order.zip,
                :country_code => "US"
          }

    recipient = { :name => "Nancy Hart",
                  :company => "Funai Service Corporation",
                  :phone_number => "855-289-6373",
                  :address => "2425 Spiegel Dr",
                  :city => "Groveport",
                  :state => "OH",
                  :postal_code => "43125",
                  :country_code => "US",
                  :residential => "false"
                }

    shipping_options = {
      :packaging_type => "YOUR_PACKAGING",
      :drop_off_type => "REGULAR_PICKUP"
    }

    fedex = Fedex::Shipment.new(:key => ENV['FEDEX_KEY_TEST'],
                        :password => ENV['FEDEX_PASSWORD_TEST'],
                        :account_number => ENV['FEDEX_ACCOUNT_TEST'],
                        :meter => ENV['FEDEX_METER_TEST'],
                        :mode => 'development')

    rate = fedex.rate(:shipper=>shipper,
                  :recipient => recipient,
                  :packages => packages,
                  :service_type => "FEDEX_GROUND",
                  :shipping_options => shipping_options)

    label = fedex.label(:filename => "example.pdf",
                    :shipper=> shipper,
                    :recipient => recipient,
                    :packages => packages,
                    :service_type => "FEDEX_GROUND",
                    :shipping_options => shipping_options)

    shipping.shipout_tracking = label.tracking_number
    shipping.label = label.file_name
    shipping.save
  end
end
