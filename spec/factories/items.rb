FactoryBot.define do

  factory :item do
    id {1}
    name {Faker::Book.title}
    brand {Faker::Company.name}
    shopping_status {0}
    send_burden {0}
    delivery_date {0}
    price {Faker::Number.number(7)}
    text {Faker::Books::CultureSeries.culture_ship}
    prefecture_id	{1}
    category_id	{995}

    after :create do |i|
        create(:sell, item: i)
        i.reload
    end
  end
end
