class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order

  def self.fedex_label(order, ship)
    shipping = Shipping.find(ship.id)
    require 'fedex'
    packages = []
    packages << {
      :weight => {:units => "LB", :value => 15},
      :dimensions => {:length => 14, :width => 9, :height => 12, :units => "IN" }
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

    example_spec = {
      :label_format_type => "COMMON2D",
      :image_type => "PDF",
      :label_stock_type => "PAPER_8.5X11_BOTTOM_HALF_LABEL"
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

    label = fedex.label(:filename => "public/uploads/labels/example.pdf",
                    :shipper=> shipper,
                    :recipient => recipient,
                    :packages => packages,
                    :service_type => "FEDEX_GROUND",
                    :shipping_options => shipping_options,
                    :label_specification => example_spec)
    rate.each do |i|
      shipping.shipping_amount = i.total_net_charge
    end
    directory = "public/uploads/labels/example.pdf"
    new_directory = "public/uploads/labels/#{label.tracking_number}.pdf"
    updated_filepath = "uploads/labels/#{label.tracking_number}.pdf"
    new_path = File.rename(directory, new_directory)
    shipping.label = updated_filepath
    shipping.shipout_tracking = label.tracking_number
    shipping.save
    mail = OrderMailer.with(order: order, shipping: shipping.shipout_tracking).label
    mail.deliver_now
  end
end
