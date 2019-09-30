FactoryBot.define do

  factory :item do
    name {Faker::Book.title}
    brand {Faker::Company.name}
    shopping_status {0}
    send_burden {0}
    delivery_date {0}
    price {Faker::Number.number(7)}
    text {Faker::Books::CultureSeries.culture_ship}
    prefecture_id	{1}
    category_id	{995}
  end
end
