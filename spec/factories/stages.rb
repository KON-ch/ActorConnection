# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    company { 'テストカンパニー' }
    start_date { '2020-12-1' }
    end_date { '2020-12-31' }
    user { FactoryBot.build(:user) }
  end
end
