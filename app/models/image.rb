class Image < ApplicationRecord
  belongs_to :order
  mount_uploader :image, ImageUploader
end
