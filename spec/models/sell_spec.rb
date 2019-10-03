require 'rails_helper'
describe Sell do
  describe '#create' do
  	# it 'item_idなしで保存できない' do
  	# 	sell = build(:sell, item_id: nil)
  	# 	sell.valid?
  	# 	binding.pry
  	# 	expect(sell.errors[:item_id]).to include("を入力してください")
  	# end
  	before do
  		@item = build(:item)
    end
  	it "is valid with full fill in" do
  		@item
      item = Item.new(id: 1,name: "ss")
      image = build(:image,image: nil,item: item.id)
      # sell = @item.sell.new(
      # 	user_id: 1,item_id: 1)
      # sell.valid?
      # expect(sell).to be_valid
      image.valid?
      binding.pry
      expect(image.errors[:image]).to include("を入力してください")
    end
  	# it 'userなしで保存できない' do
  	# 	sell = build(:sell,user_id: nil)
  	# 	sell.valid?
  	# 	expect(sell.errors[:user]).to include("を入力してください")
  	# end
  	# it 'itemなしで保存できない' do
  	# 	sell = build(:sell)
  	# 	sell.valid?
  	# 	expect(sell.errors[:item]).to include("を入力してください")
  	# end
  end
end
