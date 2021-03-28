# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stages', type: :request do
  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET #index' do
    it 'リクエストが成功すること' do
      get stages_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before do
      theater = FactoryBot.create(:theater)
      place = FactoryBot.create(:place)
      @stage = FactoryBot.create(:stage, theater: theater, place: place, request: true)
    end

    it 'リクエストが成功すること' do
      get stage_path(@stage)
      expect(response).to have_http_status(200)
    end

    it '未承認作品のリクエストが失敗すること' do
      @stage.update(request: false)
      get stage_path(@stage)
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #edit' do
    before do
      theater = FactoryBot.create(:theater)
      place = FactoryBot.create(:place)
      @stage = FactoryBot.create(:stage, theater: theater, place: place)
    end

    it 'リクエストが成功すること' do
      get edit_stage_path(@stage)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before do
      @theater = FactoryBot.create(:theater)
      @place = FactoryBot.create(:place)
    end

    context '登録が成功する場合' do
      it 'リクエストが成功すること' do
        post stages_path,
             params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id) }
        expect(response).to have_http_status(302)
      end

      it '登録が成功すること' do
        expect do
          post stages_path,
               params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id) }
        end.to change(Stage, :count).by(1)
      end

      it 'リダイレクトが成功すること' do
        post stages_path,
             params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id) }
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it 'リクエスト成功のメッセージが表示されること' do
        post stages_path,
             params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id) }
        follow_redirect!
        expect(response.body).to include 'テストタイトルをリクエストしました'
      end
    end

    context '登録が失敗する場合' do
      it '登録が失敗すること' do
        expect do
          post stages_path, params: { stage: FactoryBot.attributes_for(:stage, theater_id: '', place_id: @place.id) }
        end.to_not change(Stage, :count)
      end

      it 'エラーメッセージが表示されること' do
        post stages_path,
             params: { stage: FactoryBot.attributes_for(:stage, theater_id: '', place_id: @place.id), start_date: '' }
        follow_redirect!
        expect(response.body).to include '正しく登録されませんでした'
      end
    end
  end

  describe 'PUT #update' do
    before do
      @theater = FactoryBot.create(:theater)
      @place = FactoryBot.create(:place)
      @stage = FactoryBot.create(:stage, theater: @theater, place: @place, request: true)
    end

    context '更新される場合' do
      it 'リクエストが成功すること' do
        put stage_path(@stage),
            params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                               company: 'アップデートカンパニー') }
        expect(response).to have_http_status(302)
      end

      it '団体名が更新されること' do
        expect do
          put stage_path(@stage),
              params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                                 company: 'アップデートカンパニー') }
        end.to change { Stage.find(@stage.id).company }.from('テストカンパニー').to('アップデートカンパニー')
      end

      it 'リダイレクトが成功すること' do
        put stage_path(@stage),
            params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                               company: 'アップデートカンパニー') }
        follow_redirect!
        expect(response).to have_http_status(200)
      end

      it '更新成功のメッセージが表示されること' do
        put stage_path(@stage),
            params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                               company: 'アップデートカンパニー') }
        follow_redirect!
        expect(response.body).to include '公演情報を更新しました'
      end
    end

    context '登録が失敗する場合' do
      it '団体名が変更されないこと' do
        expect do
          put stage_path(@stage),
              params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                                 company: '') }
        end.to_not change(@stage, :company)
      end

      it '編集ページが再表示されること' do
        put stage_path(@stage),
            params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                               company: '') }
        expect(response).to render_template(:edit)
      end

      it 'エラーメッセージが表示されること' do
        put stage_path(@stage),
            params: { stage: FactoryBot.attributes_for(:stage, theater_id: @theater.id, place_id: @place.id,
                                                               company: '') }
        expect(response.body).to include '団体を入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @theater = FactoryBot.create(:theater)
      @place = FactoryBot.create(:place)
      @stage = FactoryBot.create(:stage, theater: @theater, place: @place)
    end

    it 'リクエストが成功すること' do
      delete stage_path(@stage)
      expect(response).to have_http_status(302)
    end

    it '舞台が削除されること' do
      expect do
        delete stage_path(@stage)
      end.to change(Stage, :count).by(-1)
    end

    it '一覧にリダイレクトすること' do
      delete stage_path(@stage)
      expect(response).to redirect_to(stages_path)
    end

    it '削除メッセージが表示されること' do
      delete stage_path(@stage)
      follow_redirect!
      expect(response.body).to include '公演情報を削除しました'
    end
  end
end
