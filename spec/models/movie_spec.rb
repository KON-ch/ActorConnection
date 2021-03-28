# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'Movieモデルのバリデーションテスト' do
    it 'タイトルが必須であること' do
      movie = FactoryBot.build(:movie, title: '')
      expect(movie).not_to be_valid
      expect(movie.errors[:title]).to include('を入力してください')
    end

    it '製作国が必須であること' do
      movie = FactoryBot.build(:movie, country_id: '')
      expect(movie).not_to be_valid
      expect(movie.errors[:country]).to include('を入力してください')
    end

    it '上映時間が整数であること' do
      movie = FactoryBot.build(:movie, screen_time: 90.25)
      expect(movie).not_to be_valid
      expect(movie.errors[:screen_time]).to include('は整数で入力してください')
    end

    it 'タイトルとサブタイトルの組み合わせが一意であること' do
      FactoryBot.create(:movie)
      movie = Movie.new(title: 'テストタイトル', sub_title: 'テストサブタイトル')
      expect(movie).not_to be_valid
      expect(movie.errors[:title]).to include('この作品は既に作成されています')
    end
  end
end
