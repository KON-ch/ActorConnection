# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET #index' do
    it 'リクエストが成功すること' do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end
end
