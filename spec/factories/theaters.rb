# frozen_string_literal: true

FactoryBot.define do
  factory :theater do
    title { 'テストタイトル' }
    writer { 'テスト作者' }
    user { FactoryBot.build(:user) }
    country { FactoryBot.build(:country) }
  end
end
