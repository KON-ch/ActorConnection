require 'rails_helper'

RSpec.describe "Theaters", type: :system do
  before "ログインをする" do
    user = FactoryBot.build(:user)
    visit "/signup"
    fill_in 'ニックネーム', with: user.name
    fill_in 'メールアドレス', with: user.email
    select user.birthday.year, :from => 'user_birthday_1i'
    select user.birthday.mon, :from => 'user_birthday_2i'
    select user.birthday.day, :from => 'user_birthday_3i'
    choose "user_sex_男性"
    fill_in 'パスワード', with: user.password
    fill_in 'パスワード(確認用)', with: user.password_confirmation
    click_button 'アカウント作成'
  end

  it "戯曲情報を登録する" do
      theater = FactoryBot.build(:theater)
      country = FactoryBot.create(:country)
      visit "/theaters"
      find('.fa-plus').click
      fill_in '題名', with: theater.title
      fill_in '作者', with: theater.writer
      select '日本', from: 'theater_country_id'
      click_button '登録'
      expect(page).to have_content 'テストタイトル'
  end

end