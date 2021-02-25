require 'rails_helper'

RSpec.describe Place, type: :model do
  
  describe "Placeモデルのバリデーションテスト" do
    
    it "劇場名が必須であること" do
      place = FactoryBot.build(:place, name: "")
      expect(place).not_to be_valid
      expect(place.errors[:name]).to include('を入力してください')
    end

    it "住所が必須であること" do
      place = FactoryBot.build(:place, address: "")
      expect(place).not_to be_valid
      expect(place.errors[:address]).to include('を入力してください')
    end
    
    it "劇場名が一意であること" do
      FactoryBot.create(:place)
      place = Place.new(name: "テスト劇場")
      expect(place).not_to be_valid
      expect(place.errors[:name]).to include('はすでに存在します')
    end
    
    it "緯度が数値であること" do
      place = FactoryBot.build(:place, latitude: "テスト")
      expect(place).not_to be_valid
      expect(place.errors[:latitude]).to include('は数値で入力してください')
    end

    it "経度が数値であること" do
      place = FactoryBot.build(:place, longitude: "テスト")
      expect(place).not_to be_valid
      expect(place.errors[:longitude]).to include('は数値で入力してください')
    end
  end
end
