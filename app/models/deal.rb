class Deal < ApplicationRecord
	belongs_to :seller, :class_name=>'User'
	belongs_to :buyer, :class_name=>'User'
	belongs_to :item
	has_many :items_of_seller, :through => :deals_of_seller
	#自分自信を参照するassociation
end
