require 'fedex'
require 'csv'
namespace :my_fedex do
  desc "Check rates on sample database"
  task my_rates_check: :environment do

    examples = Sample.where(original_delivery_return_net: [nil, ""])

    examples.each do |my_item|
      packages = []
      if my_item.original_delivery_main_model_size == "22"
       packages << {
        :weight => {:units => "LB", :value => 10},
        :dimensions => {:length => 20, :width => 24, :height => 16, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "24"
       packages << {
        :weight => {:units => "LB", :value => 10},
        :dimensions => {:length => 23, :width => 22, :height => 13, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "32"
        packages << {
          :weight => {:units => "LB", :value => 12},
          :dimensions => {:length => 32, :width => 5, :height => 20, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "40"
        packages << {
          :weight => {:units => "LB", :value => 18},
          :dimensions => {:length => 39, :width => 6, :height => 24, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "43"
        packages << {
          :weight => {:units => "LB", :value => 18},
          :dimensions => {:length => 39, :width => 6, :height => 24, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "50"
        packages << {
          :weight => {:units => "LB", :value => 30},
          :dimensions => {:length => 51, :width => 8, :height => 33, :units => "IN" }
        }
      elsif my_item.original_delivery_main_model_size == "55"
        packages << {
          :weight => {:units => "LB", :value => 35},
          :dimensions => {:length => 54, :width => 9, :height => 35, :units => "IN" }
        }
      end

      p shipper = {
                  :city => my_item.original_delivery_main_city,
                  :state => my_item.original_delivery_main_state,
                  :postal_code => my_item.original_delivery_main_zip,
                  :country_code => my_item.original_delivery_main_country
                }

      p recipient = {
                  :city => my_item.original_delivery_return_city,
                  :state => my_item.original_delivery_return_state,
                  :postal_code => my_item.original_delivery_return_zip,
                  :country_code => my_item.original_delivery_return_country,
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
                          :mode => 'production')
      begin
        rate = fedex.rate(:shipper=>shipper,
                    :recipient => recipient,
                    :packages => packages,
                    :service_type => "FEDEX_GROUND",
                    :shipping_options => shipping_options)

      rescue  Fedex::RateError => msg
        puts "#{msg} Please try again at a later time"
      end
      p rate
      if rate.nil?
        my_item.original_delivery_return_net = 0
      else
        rate.each do |i|
          my_item.original_delivery_return_net = i.total_net_charge
          my_item.original_delivery_return_time = i.transit_time
        end
      end
      my_item.save
      puts "#{my_item.original_delivery_main_model}-#{my_item.original_net}"
      p packages
      puts "-----------------------------------------------------------------"
      sleep(1)
    end
  end
  desc "Download csv file"
  task download_sample: :environment do
    a = Sample.order(:original_net)
    directory = "#{Rails.root}/public/file.csv"
    attributes = ["express_tracking",
                      "original_net",
                      "original_service",
                      "ship_date",
                      "original_delivery_name",
                      "original_delivery_address",
                      "original_delivery_city",
                      "original_delivery_state",
                      "original_delivery_zip",
                      "original_delivery_country",
                      "original_delivery_customer_reference",
                      "original_delivery_customer_po",
                      "original_delivery_customer_description",
                      "original_delivery_main_rma",
                      "original_delivery_main_name",
                      "original_delivery_main_address",
                      "original_delivery_main_city",
                      "original_delivery_main_state",
                      "original_delivery_main_country",
                      "original_delivery_main_zip",
                      "original_delivery_main_phone",
                      "original_delivery_main_model",
                      "original_delivery_main_model_size",
                      "original_delivery_return_name",
                      "original_delivery_return_address",
                      "original_delivery_return_city",
                      "original_delivery_return_state",
                      "original_delivery_return_country",
                      "original_delivery_return_zip",
                      "original_delivery_return_net",
                      "original_delivery_return_time"
                    ]
    CSV.open(directory, "wb") do |csv|
      csv << attributes
      a.each do |item|
        csv << [item.express_tracking,
          item.original_net,
          item.original_service,
          item.ship_date,
          item.original_delivery_name,
          item.original_delivery_address,
          item.original_delivery_city,
          item.original_delivery_state,
          item.original_delivery_zip,
          item.original_delivery_country,
          item.original_delivery_customer_reference,
          item.original_delivery_customer_po,
          item.original_delivery_customer_description,
          item.original_delivery_main_rma,
          item.original_delivery_main_name,
          item.original_delivery_main_address,
          item.original_delivery_main_city,
          item.original_delivery_main_state,
          item.original_delivery_main_country,
          item.original_delivery_main_zip,
          item.original_delivery_main_phone,
          item.original_delivery_main_model,
          item.original_delivery_main_model_size,
          item.original_delivery_return_name,
          item.original_delivery_return_address,
          item.original_delivery_return_city,
          item.original_delivery_return_state,
          item.original_delivery_return_country,
          item.original_delivery_return_zip,
          item.original_delivery_return_net,
          item.original_delivery_return_time]
    end
  end
end
end
