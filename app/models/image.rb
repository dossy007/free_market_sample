class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ImageUploader
  with_options if: :update? do |v|
  	validates :image, presence: true
  end
end
