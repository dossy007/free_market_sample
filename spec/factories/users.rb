FactoryBot.define do

  factory :user do
    nickname {Faker::Internet.user_name}
    email   {Faker::Internet.free_email}
    password {111111}
    password_confirmation {111111}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_kana	{"ひが"}
    first_kana	{"しょうご"}
    postal_code {Faker::Address.postcode}
    prefecture_id	{"0"}
    city_name	{Faker::Address.city}
    building_name   {Faker::Address.street_name}
    house_number {Faker::Address.street_address}
  end
end
