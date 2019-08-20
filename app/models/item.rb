class Item < ApplicationRecord
  has_many :images
  has_many :deals
	has_many :sellers, :through => :deals
	has_many :buyers, :through => :deals
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
end
