FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password = Faker::Internet.password(6)
    password_confirmation = Faker::Internet.password(8)
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_kana	{"ひが"}
    first_kana	{"しょうご"}
    postal_code {Faker::Address::postcode}
    prefecture_id	{"0"}
    city_name	{Faker::Address::city}
    building_name	{"札幌1-1-1"}
    house_number	{"比嘉コーポ101"}
  end
end
