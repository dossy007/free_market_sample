
require 'rails_helper'
describe User do
  describe '#create' do
    it "nicknameなしでcreateは無効" do
    	user = build(:user, nickname: nil)
    	user.valid?
    	expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "emailなしでcreateは無効" do
    	user = build(:user ,email: nil)
    	user.valid?
    	expect(user.errors[:email]).to include("can't be blank")
    end
    it "passなしでcreateは無効" do
    	user = build(:user ,password: nil)
    	user.valid?
    	expect(user.errors[:password]).to include("can't be blank")
    end
    it "confirm_passとpasswordがmatchしないとcreateは無効" do
    	user = build(:user ,password_confirmation: "")
    	user.valid?
    	expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "last_nameなしでcreateは無効" do
        user = build(:user, last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "first_nameなしでcreateは無効" do
        user = build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "last_kanaなしでcreateは無効" do
        user = build(:user, last_kana: nil)
        user.valid?
        expect(user.errors[:last_kana]).to include("can't be blank")
    end
    it "first_kanaなしでcreateは無効" do
        user = build(:user, first_kana: nil)
        user.valid?
        expect(user.errors[:first_kana]).to include("can't be blank")
    end
    it "postal_codeなしでcreateは無効" do
        user = build(:user, postal_code: nil)
        user.valid?
        expect(user.errors[:postal_code]).to include("can't be blank")
    end
    it "prefecture_idなしでcreateは無効" do
        user = build(:user, prefecture_id: nil)
        user.valid?
        expect(user.errors[:prefecture_id]).to include("can't be blank")
    end
    it "city_nameなしでcreateは無効" do
        user = build(:user, city_name: nil)
        user.valid?
        expect(user.errors[:city_name]).to include("can't be blank")
    end
    it "house_numberなしでcreateは無効" do
        user = build(:user, house_number: nil)
        user.valid?
        expect(user.errors[:house_number]).to include("can't be blank")
    end
  end
end
