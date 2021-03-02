require 'rails_helper'

RSpec.describe "Movies", type: :request do

  before do
    user = create(:user)
    sign_in user
  end
  
  describe "GET #index" do
    it "リクエストが成功すること" do
      get movies_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #show" do

    before do
      country = FactoryBot.create(:country)
      @movie = FactoryBot.create(:movie, country: country, request: true)
    end

    it "リクエストが成功すること" do
      get movie_path(@movie)
      expect(response).to have_http_status(200)
    end

    it "未承認作品のリクエストが失敗すること" do
      @movie.update(request: false)
      get movie_path(@movie)
      expect(response).to have_http_status(302)
    end

  end

  describe "GET #edit" do
    
    before do
      country = FactoryBot.create(:country)
      @movie = FactoryBot.create(:movie, country: country)
    end

    it "リクエストが成功すること" do
      get edit_movie_path(@movie)
      expect(response).to have_http_status(200)
    end

  end

  describe "POST #create" do

    before do
      @country = FactoryBot.create(:country)
    end

    context '登録が成功する場合' do

      it "リクエストが成功すること" do
        post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id)}
        expect(response).to have_http_status(302)
      end
      
      it "登録が成功すること" do
        expect do
          post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id)}
        end.to change(Movie, :count).by(1)
      end

      it "リダイレクトが成功すること" do
        post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, )}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "リクエスト成功のメッセージが表示されること" do
        post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id)}
        follow_redirect!
        expect(response.body).to include 'テストタイトルをリクエストしました'
      end
    end

    context '登録が失敗する場合' do
      
      it "登録が失敗すること" do
        expect do
          post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title:"")}
        end.to_not change(Movie, :count)
      end

      it "エラーメッセージが表示されること" do
        post movies_path, params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title:"")}
        follow_redirect!
        expect(response.body).to include '正しく登録されませんでした'
      end
    end

  end

  describe "PUT #update" do

    before do
      @country = FactoryBot.create(:country)
      @movie = FactoryBot.create(:movie, country: @country, request: true)
    end

    context '更新される場合' do

      it "リクエストが成功すること" do
        put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "アップデートタイトル")}
        expect(response).to have_http_status(302)
      end
      
      it "タイトルが更新されること" do
        expect do
          put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "アップデートタイトル")}
        end.to change{Movie.find(@movie.id).title}.from('テストタイトル').to('アップデートタイトル')
      end

      it "リダイレクトが成功すること" do
        put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "アップデートタイトル")}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "更新成功のメッセージが表示されること" do
        put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "アップデートタイトル")}
        follow_redirect!
        expect(response.body).to include '映画情報を更新しました'
      end
    end

    context '登録が失敗する場合' do
      
      it "タイトルが変更されないこと" do
        expect do
          put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "")}
        end.to_not change(@movie, :title)
      end

      it "編集ページが再表示されること" do
        put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "")}
        expect(response).to render_template(:edit)
      end

      it "エラーメッセージが表示されること" do
        put movie_path(@movie), params: {movie: FactoryBot.attributes_for(:movie, country_id: @country.id, title: "")}
        expect(response.body).to include '題名を入力してください'
      end
    end

  end

  describe "DELETE #destroy" do

    before do
      country = FactoryBot.create(:country)
      @movie = FactoryBot.create(:movie, country: country)
    end

    it "リクエストが成功すること" do
      delete movie_path(@movie)
      expect(response).to have_http_status(302)
    end

    it "舞台が削除されること" do
      expect do
        delete movie_path(@movie)
      end.to change(Movie, :count).by(-1)
    end

    it "一覧にリダイレクトすること" do
      delete movie_path(@movie)
      expect(response).to redirect_to(movies_path)
    end

    it "削除メッセージが表示されること" do
      delete movie_path(@movie)
      follow_redirect!
      expect(response.body).to include '映画情報を削除しました'
    end

  end  
end
