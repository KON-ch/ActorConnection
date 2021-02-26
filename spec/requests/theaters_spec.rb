require 'rails_helper'

RSpec.describe "Theaters", type: :request do

  before do
    user = create(:user)
    sign_in user
  end
  
  describe "GET #index" do
    it "リクエストが成功すること" do
      get theaters_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #show" do

    before do
      @theater = FactoryBot.create(:theater)
    end

    it "リクエストが成功すること" do
      get theater_path(@theater)
      expect(response).to have_http_status(200)
    end

  end

  describe "GET #edit" do
    
    before do
      @theater = FactoryBot.create(:theater)
    end

    it "リクエストが成功すること" do
      get edit_theater_path(@theater)
      expect(response).to have_http_status(200)
    end

  end

  describe "POST #create" do

    before do
      @country = FactoryBot.create(:country)
    end

    describe '登録が成功する場合' do

      it "リクエストが成功すること" do
        post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id)}
        expect(response).to have_http_status(302)
      end
      
      it "登録が成功すること" do
        expect do
          post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id)}
        end.to change(Theater, :count).by(1)
      end

      it "リダイレクトが成功すること" do
        post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id)}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
          post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id)}
          follow_redirect!
          expect(response.body).to include '戯曲情報を登録しました'
      end
    end

    describe '登録が失敗する場合' do
      
      it "登録が失敗すること" do
        expect do
          post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, writer: "")}
        end.to_not change(Theater, :count)
      end

      it "エラーメッセージが表示されること" do
        post theaters_path, params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, writer:"")}
        follow_redirect!
        expect(response.body).to include '正しく登録されませんでした'
      end
    end

  end

  describe "PUT #update" do

    before do
      @country = FactoryBot.create(:country)
      @theater = FactoryBot.create(:theater, country_id: @country.id)
    end

    describe '更新される場合' do

      it "リクエストが成功すること" do
        put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "テストアップデートタイトル")}
        expect(response).to have_http_status(302)
      end
      
      it "作品名が更新されること" do
        expect do
          put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "テストアップデートタイトル")}
        end.to change{Theater.find(@theater.id).title}.from('テストタイトル').to('テストアップデートタイトル')
      end

      it "リダイレクトが成功すること" do
        put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "テストアップデートタイトル")}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
          put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "テストアップデートタイトル")}
          follow_redirect!
          expect(response.body).to include '戯曲情報を更新しました'
      end
    end

    describe '登録が失敗する場合' do
      
      it "作品名が変更されないこと" do
        expect do
          put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "")}
        end.to_not change(@theater, :title)
      end

      it "編集ページが再表示されること" do
        put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "")}
        expect(response).to render_template(:edit)
      end

      it "エラーメッセージが表示されること" do
        put theater_path(@theater), params: {theater: FactoryBot.attributes_for(:theater, country_id: @country.id, title: "")}
        expect(response.body).to include '題名を入力してください'
      end
    end

  end

  describe "DELETE #destroy" do

    before do
      @theater = FactoryBot.create(:theater)
    end

    it "リクエストが成功すること" do
      delete theater_path(@theater)
      expect(response).to have_http_status(302)
    end

    it "戯曲が削除されること" do
      expect do
        delete theater_path(@theater)
      end.to change(Theater, :count).by(-1)
    end

    it "一覧にリダイレクトすること" do
      delete theater_path(@theater)
      expect(response).to redirect_to(theaters_path)
    end

    it "削除メッセージが表示されること" do
      delete theater_path(@theater)
      follow_redirect!
      expect(response.body).to include '戯曲情報を削除しました'
    end

  end

end
