FactoryBot.define do
  factory :user, class: User do
    name { 'テストネーム' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    birthday { '1991-11-11' }
    sex { 1 }
  end
end
