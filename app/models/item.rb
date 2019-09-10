class Item < ApplicationRecord
  has_many :images
	has_many :users, through: :sell
	has_many :users, through: :buy
  has_one :sell
  has_one :buy
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
end
