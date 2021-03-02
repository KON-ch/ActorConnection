require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Reviewモデルのバリデーションテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    it '評価が必須であること' do
      review = FactoryBot.build(:review, user: @user, rate: '')
      expect(review).not_to be_valid
      expect(review.errors[:rate]).to include('は数値で入力してください')
    end

    it '評価が1以上であること' do
      review = FactoryBot.build(:review, user: @user, rate: 0)
      expect(review).not_to be_valid
      expect(review.errors[:rate]).to include('は1以上の値にしてください')
    end

    it '評価が5以下であること' do
      review = FactoryBot.build(:review, user: @user, rate: 6)
      expect(review).not_to be_valid
      expect(review.errors[:rate]).to include('は5以下の値にしてください')
    end

    it 'レビューの文字数が170以内であること' do
      review = FactoryBot.build(:review,
                                content: 'テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュ ー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。テストレビュー。')
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include('は170文字以内で入力してください')
    end
  end
end
