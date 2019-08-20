class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:facebook,:google_oauth2]
  validates :nickname,:last_name,:first_name,:last_kana,:first_kana,:postal_code,:prefecture_id,:city_name,:house_number, presence: true
  validates :password, length: {minimum: 6}

  ##Assosiation
    has_many :sns_credentials, ->  { denpendent (:destroy) }
  	belongs_to :user, optional: true
    has_one :card
    has_many :deals_of_seller, :class_name => 'Deal', :foreign_key =>'seller_id'
		has_many :deals_of_buyer, :class_name => 'Deal', :foreign_key =>'buyer_id'
		has_many :items_of_seller, :through => :deals_of_seller, :source =>'item'
		has_many :items_of_buyer, :through => :deals_of_buyer, :source => 'item'
  extend ActiveHash::Associations::ActiveRecordExtensions
  	belongs_to_active_hash :prefecture


	def self.find_oauth(auth)
		uid = auth.uid
		provider = auth.provider
		snscredentials = SnsCredential.where(uid: uid, provider: provider).first

	 	if snscredentials.present? #sns登録のみ完了してるuser
	 		user = User.where(id: snscredential.user_id).first
	 		unless user.present?
	 			user = User.new(
	 				nickname: auth.info.name,
	 				email: auth.info.email
	 				)
	 		end
	 		sns = snscredential
	 	else #sns未登録
	 		user = User.where(email: auth.info.email).first
	 		if user.present?
	 			sns = SnsCredential.new(
	 				uid: uid,
	 				provider: provider,
	 				user_id: user.id
	 				)
	 		else
	 			user = User.new(
	 				nickname: auth.info.name,
	 				email: auth.info.email
	 				)
	 			sns = SnsCredential.create(
	 				uid: uid,
	 				provider: provider
	 				)
	 		end
	  end
	  return {user: user, sns_id: sns.id}
	end
end
