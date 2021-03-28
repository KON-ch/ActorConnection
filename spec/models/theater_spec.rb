# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theater, type: :model do
  describe 'Theaterモデルのバリデーションテスト' do
    context '必須入力であること' do
      it '題名が必須であること' do
        theater = FactoryBot.build(:theater, title: '')
        expect(theater).not_to be_valid
        expect(theater.errors[:title]).to include('を入力してください')
      end

      it '作者が必須であること' do
        theater = FactoryBot.build(:theater, writer: '')
        expect(theater).not_to be_valid
        expect(theater.errors[:writer]).to include('を入力してください')
      end
    end

    context '入力値が自然数であること' do
      it '男の登場人数が自然数であること' do
        theater = FactoryBot.build(:theater, man: 1.5)
        expect(theater).not_to be_valid
        expect(theater.errors[:man]).to include('は整数で入力してください')
      end

      it '女の登場人数が自然数であること' do
        theater = FactoryBot.build(:theater, female: -1)
        expect(theater).not_to be_valid
        expect(theater.errors[:female]).to include('は0以上の値にしてください')
      end
    end

    context '一意であること' do
      it '題名と作者の組み合わせが一意であること' do
        FactoryBot.create(:theater)
        theater = Theater.new(title: 'テストタイトル', writer: 'テスト作者')
        expect(theater).not_to be_valid
        expect(theater.errors[:title]).to include('この作品は既に作成されています')
      end
    end
  end
end
