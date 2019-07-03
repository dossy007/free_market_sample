class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:facebook]
  validates :nickname,:last_name,:first_name,:last_kana,:first_kana,:postal_code,:prefecture_id,:city_name,:house_number, presence: true
  validates :password, length: {minimum: 6}

  ##Assosiation
  has_many :sns_credentials, denpendent: :destroy
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
   belongs_to_active_hash :prefecture
end
