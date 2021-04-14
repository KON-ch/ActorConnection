FactoryBot.define do
  factory :admin, class: Admin do
    name { 'テストネーム' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end