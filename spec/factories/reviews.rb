# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rate { 3 }
    content { 'テストレビュー' }
  end
end
