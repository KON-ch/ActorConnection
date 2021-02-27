require 'rails_helper'

RSpec.describe "Reviews", type: :request do

  before do
    @user = create(:user)
    sign_in @user
  end

  describe "POST #create" do

    context '戯曲にレビューする場合' do

      before do
        @theater = FactoryBot.create(:theater)
      end

      it "リクエストが成功すること" do
        post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater))}
        expect(response).to have_http_status(302)
      end
      
      it "登録が成功すること" do
        expect do
          post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater))}
        end.to change(Review, :count).by(1)
      end

      it "リダイレクトが成功すること" do
        post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater))}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
        post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater))}
          follow_redirect!
          expect(response.body).to include 'レビューを作成しました'
      end
      
      it "登録が失敗すること" do
        expect do
          post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater), content: "")}
        end.to_not change(Review, :count)
      end

      it "エラーメッセージが表示されること" do
        post theater_reviews_path(@theater), params: {review: FactoryBot.attributes_for(:review, theater_id: @theater.id, review_page: theater_path(@theater), content: "")}
        follow_redirect!
        expect(response.body).to include 'レビューに失敗しました'
      end
    end

    context '映画にレビューする場合' do

      before do
        @movie = FactoryBot.create(:movie)
      end

      it "リクエストが成功すること" do
        post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie))}
        expect(response).to have_http_status(302)
      end
      
      it "登録が成功すること" do
        expect do
          post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie))}
        end.to change(Review, :count).by(1)
      end

      it "リダイレクトが成功すること" do
        post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie))}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
        post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie))}
          follow_redirect!
          expect(response.body).to include 'レビューを作成しました'
      end
      
      it "登録が失敗すること" do
        expect do
          post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie), content: "")}
        end.to_not change(Review, :count)
      end

      it "エラーメッセージが表示されること" do
        post movie_reviews_path(@movie), params: {review: FactoryBot.attributes_for(:review, movie_id: @movie.id, review_page: movie_path(@movie), content: "")}
        follow_redirect!
        expect(response.body).to include 'レビューに失敗しました'
      end
    end

    context '舞台にレビューする場合' do

      before do
        theater = FactoryBot.create(:theater)
        place = FactoryBot.create(:place)
        @stage = FactoryBot.create(:stage, theater: theater, place: place)
      end

      it "リクエストが成功すること" do
        post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage))}
        expect(response).to have_http_status(302)
      end
      
      it "登録が成功すること" do
        expect do
          post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage))}
        end.to change(Review, :count).by(1)
      end

      it "リダイレクトが成功すること" do
        post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage))}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
        post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage))}
          follow_redirect!
          expect(response.body).to include 'レビューを作成しました'
      end
      
      it "登録が失敗すること" do
        expect do
          post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage), content: "")}
        end.to_not change(Review, :count)
      end

      it "エラーメッセージが表示されること" do
        post stage_reviews_path(@stage), params: {review: FactoryBot.attributes_for(:review, stage_id: @stage.id, review_page: stage_path(@stage), content: "")}
        follow_redirect!
        expect(response.body).to include 'レビューに失敗しました'
      end
    end

  end

  describe "PUT #update" do

    before do
      @review = FactoryBot.create(:review, user: @user)
    end

    context '更新される場合' do

      it "リクエストが成功すること" do
        put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "テストアップデートレビュー")}
        expect(response).to have_http_status(302)
      end
      
      it "レビューが更新されること" do
        expect do
          put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "テストアップデートレビュー")}
        end.to change{Review.find(@review.id).content}.from('テストレビュー').to('テストアップデートレビュー')
      end

      it "リダイレクトが成功すること" do
        put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "テストアップデートレビュー")}
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it "登録成功のメッセージが表示されること" do
        put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "テストアップデートレビュー")}
          follow_redirect!
          expect(response.body).to include 'レビューを編集しました'
      end
    end

    context '更新が失敗する場合' do
      
      it "レビューが変更されないこと" do
        expect do
          put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "")}
        end.to_not change(@review, :content)
      end

      it "編集ページが再表示されること" do
        put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "")}
        expect(response).to redirect_to(root_path)
      end

      it "エラーメッセージが表示されること" do
        put review_path(@review), params: {review: FactoryBot.attributes_for(:review,review_page: root_path, content: "")}
        follow_redirect!
        expect(response.body).to include '編集に失敗しました'
      end
    end

    describe "DELETE #destroy" do

      before do
        @review = FactoryBot.create(:review, user: @user)
      end
  
      it "リクエストが成功すること" do
        delete review_path(@review), params: {review: FactoryBot.attributes_for(:review), review_page: root_path}
        expect(response).to have_http_status(302)
      end
  
      it "レビューが削除されること" do
        expect do
          delete review_path(@review), params: {review: FactoryBot.attributes_for(:review),review_page: root_path}
        end.to change(Review, :count).by(-1)
      end
  
      it "一覧にリダイレクトすること" do
        delete review_path(@review), params: {review: FactoryBot.attributes_for(:review),review_page: root_path}
        expect(response).to redirect_to(root_path)
      end
  
      it "削除メッセージが表示されること" do
        delete review_path(@review), params: {review: FactoryBot.attributes_for(:review),review_page: root_path}
        follow_redirect!
        expect(response.body).to include 'レビューを削除しました'
      end
  
    end  

  end
end
