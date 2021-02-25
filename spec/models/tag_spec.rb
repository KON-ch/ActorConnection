require 'rails_helper'

RSpec.describe Tag, type: :model do
  
  describe "Tagモデルのバリデーションテスト" do
    
    it "タグ名が必須であること" do
      tag = FactoryBot.build(:tag, name: "")
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include('を入力してください')
    end
    
    it "タグ名が一意であること" do
      FactoryBot.create(:tag)
      tag = Tag.new(name: "テストタグ")
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include('はすでに存在します')
    end
end
end
