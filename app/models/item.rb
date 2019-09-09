class Item < ApplicationRecord
  has_many :images
	has_many :users, through: :sell
	has_many :users, through: :buy
	has_one :sell
	has_one :buy
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture

  enum shopping_status: [:unused,:near_used,:no_dirt,:some_dirt,:dirt,:bad_condition],
  		 send_burden: [:postage_included,:cash_on_delivery],
  		 delivery_date:[:ship_in_1_2days,:ship_in_2_3days,:ship_in_4_7days]
end
