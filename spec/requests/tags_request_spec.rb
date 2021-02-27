require 'rails_helper'

RSpec.describe "Tags", type: :request do

  before do
    user = create(:user)
    sign_in user
  end
  
  describe "GET #show" do
    it "リクエストが成功すること" do
      @tag = FactoryBot.create(:tag)
      get tag_path(@tag)
      expect(response).to have_http_status(200)
    end

  end
  
end
