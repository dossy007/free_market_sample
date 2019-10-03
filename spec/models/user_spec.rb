
require 'rails_helper'
describe User do
  describe '#create' do
    it "nicknameなしでcreateは無効" do
    	user = build(:user, nickname: nil)
    	user.valid?
    	expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailなしでcreateは無効" do
    	user = build(:user ,email: nil)
    	user.valid?
    	expect(user.errors[:email]).to include("を入力してください")
    end
    it "passなしでcreateは無効" do
    	user = build(:user ,password: nil)
    	user.valid?
    	expect(user.errors[:password]).to include("を入力してください")
    end
    it "confirm_passとpasswordがmatchしないとcreateは無効" do
    	user = build(:user ,password_confirmation: "")
    	user.valid?
    	expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end
    it "last_nameなしでcreateは無効" do
        user = build(:user, last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("を入力してください")
    end
    it "first_nameなしでcreateは無効" do
        user = build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("を入力してください")
    end
    it "last_kanaなしでcreateは無効" do
        user = build(:user, last_kana: nil)
        user.valid?
        expect(user.errors[:last_kana]).to include("を入力してください")
    end
    it "first_kanaなしでcreateは無効" do
        user = build(:user, first_kana: nil)
        user.valid?
        expect(user.errors[:first_kana]).to include("を入力してください")
    end
    it "postal_codeなしでcreateは無効" do
        user = build(:user, postal_code: nil)
        user.valid?
        expect(user.errors[:postal_code]).to include("を入力してください")
    end
    it "prefecture_idなしでcreateは無効" do
        user = build(:user, prefecture_id: nil)
        user.valid?
        expect(user.errors[:prefecture_id]).to include("を入力してください")
    end
    it "city_nameなしでcreateは無効" do
        user = build(:user, city_name: nil)
        user.valid?
        expect(user.errors[:city_name]).to include("を入力してください")
    end
    it "house_numberなしでcreateは無効" do
        user = build(:user, house_number: nil)
        user.valid?
        expect(user.errors[:house_number]).to include("を入力してください")
    end
    it "passwordが6文字以上でないとcreateは無効" do
        user = build(:user ,password: "00000")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end
