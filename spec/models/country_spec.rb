require 'rails_helper'

RSpec.describe Country, type: :model do

  describe "Countryモデルのバリデーションテスト" do
    
      it "国名が必須であること" do
        country = FactoryBot.build(:country, name: "")
        expect(country).not_to be_valid
        expect(country.errors[:name]).to include('を入力してください')
      end
      
      it "国名が一意であること" do
        FactoryBot.create(:country)
        country = Country.new(name: "日本")
        expect(country).not_to be_valid
        expect(country.errors[:name]).to include('はすでに存在します')
      end
  end
end
