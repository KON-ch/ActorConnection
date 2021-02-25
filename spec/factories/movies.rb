FactoryBot.define do
  factory :movie do
    title {'テストタイトル'}
    sub_title {'テストサブタイトル'}
    screen_time {90}
    user { FactoryBot.build(:user) }
    country { FactoryBot.build(:country) }
  end
end
