require 'rails_helper'

RSpec.describe Plice, type: :model do
  describe 'Pliceモデルのバリデーションテスト' do
    it '料金名が必須であること' do
      plice = FactoryBot.build(:plice, name: '')
      expect(plice).not_to be_valid
      expect(plice.errors[:name]).to include('を入力してください')
    end
    it '料金が必須であること' do
      plice = FactoryBot.build(:plice, fee: '')
      expect(plice).not_to be_valid
      expect(plice.errors[:fee]).to include('を入力してください')
    end
    it '料金が数値であること' do
      plice = FactoryBot.build(:plice, fee: "テスト料金")
      expect(plice).not_to be_valid
      expect(plice.errors[:fee]).to include('は数値で入力してください')
    end
  end
  
end
