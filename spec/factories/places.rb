FactoryBot.define do
  factory :place do
    name { 'テスト劇場' }
    address { '東京都テスト区' }
    latitude { '11.111111' }
    longitude { '22.222222' }
  end
end
