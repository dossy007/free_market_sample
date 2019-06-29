FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    last_name	{"比嘉"}
    first_name	{"将吾"}
    last_kana	{"ひが"}
    first_kana	{"しょうご"}
    postal_code	{"664-0858"}
    prefecture_id	{"0"}
    city_name	{"札幌市"}
    building_name	{"札幌1-1-1"}
    house_number	{"比嘉コーポ101"}
  end
end
