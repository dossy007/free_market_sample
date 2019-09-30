require 'rails_helper'
describe Item do
	describe '#create' do
		it "is valid with full fill in" do
      item = build(:item)
      expect(item).to be_valid
    end
		it 'nameなしで保存できない' do
			item = build(:item, name: nil)
    	item.valid?
    	expect(item.errors[:name]).to include("を入力してください")
		end
		it 'textなしで保存できない' do
			item = build(:item, text: nil)
    	item.valid?
    	expect(item.errors[:text]).to include("を入力してください")
		end
		it 'categoryなしで保存できない' do
			item = build(:item, category_id: nil)
    	item.valid?
    	expect(item.errors[:category_id]).to include("を入力してください")
		end
		it 'shopping_statusなしで保存できない' do
			item = build(:item, shopping_status: nil)
    	item.valid?
    	expect(item.errors[:shopping_status]).to include("を入力してください")
		end
		it 'send_burdenなしで保存できない' do
			item = build(:item, send_burden: nil)
    	item.valid?
    	expect(item.errors[:send_burden]).to include("を入力してください")
		end
		it 'prefecture_idなしで保存できない' do
			item = build(:item, prefecture_id: nil)
    	item.valid?
    	expect(item.errors[:prefecture_id]).to include("を入力してください")
		end
		it 'delivery_date' do
			item = build(:item, delivery_date: nil)
    	item.valid?
    	expect(item.errors[:delivery_date]).to include("を入力してください")
		end
		it 'priceなしで保存できない' do
			item = build(:item, price: nil)
    	item.valid?
    	expect(item.errors[:price]).to include("を入力してください")
		end
		it 'nameが40文字以上なら保存できない' do
			item = build(:item, name: "111111111111111111111111111111111111111111")
    	item.valid?
    	expect(item.errors[:name]).to include("は40文字以内で入力してください")
		end
		it 'textは1000文字以内でないと保存できない' do
			item = build(:item, text: Faker::Lorem.paragraph(100))
    	item.valid?
    	expect(item.errors[:text]).to include("は1000文字以内で入力してください")
		end
	end
end
