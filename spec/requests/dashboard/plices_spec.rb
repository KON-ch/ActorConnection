require 'rails_helper'

RSpec.describe "Dashboard::Plices", type: :request do
  before do
    admin = create(:admin)
    sign_in admin
  end
  
  describe "GET /index" do
    it 'リクエストが成功すること' do
      get dashboard_plices_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do

    context '登録が失敗する場合' do
      it '登録が失敗すること' do
        expect do
          post dashboard_plices_path, params: { plice: FactoryBot.attributes_for(:plice, name: '') }
        end.to_not change(Plice, :count)
      end

      it 'エラーメッセージが表示されること' do
        post dashboard_plices_path, params: { plice: FactoryBot.attributes_for(:plice, name: '') }
        follow_redirect!
        expect(response.body).to include '登録に失敗しました'
      end
    end
  end
end
