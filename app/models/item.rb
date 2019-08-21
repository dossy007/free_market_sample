class Item < ApplicationRecord
  has_many :images
  # has_many :deals
	# has_many :users, :through => :dealsells
	# has_many :users, :through => :dealbuys
	has_many :users, through: :sell
	has_many :users, through: :buy
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
end
