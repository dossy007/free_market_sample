FactoryBot.define do
	factory :image do
		image {Faker::Name.name}
		item_id {1}
	end
end
