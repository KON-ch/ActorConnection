require 'rails_helper'

RSpec.describe Review, type: :model do
  
  describe "Reviewモデルのバリデーションテスト" do
    
    it "レビューが必須であること" do
      review = FactoryBot.build(:review, content: "")
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include('を入力してください')
    end
    
    it "レビューの文字数が170以内であること" do
      review = FactoryBot.build(:review, 
        content: "テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュ ー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。")
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include('は170文字以内で入力してください')
    end
  end
end
