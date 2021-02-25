require 'rails_helper'

RSpec.describe Stage, type: :model do

  describe "Stageモデルのバリデーションテスト" do
    
    before do
      @theater = FactoryBot.create(:theater)
    end
    
    context '必須入力であること' do

      it "作品が必須であること" do
        stage = FactoryBot.build(:stage)
        expect(stage).not_to be_valid
        expect(stage.errors[:theater]).to include('を入力してください')
      end
      
      it "開演日が必須であること" do
        stage = FactoryBot.build(:stage, theater: @theater, start_date: "")
        expect(stage).not_to be_valid
        expect(stage.errors[:start_date]).to include('を入力してください')
      end
      
      it "終演日が必須であること" do
        stage = FactoryBot.build(:stage, theater: @theater, end_date: "")
        expect(stage).not_to be_valid
        expect(stage.errors[:end_date]).to include('を入力してください')
      end

      it "団体名が必須であること" do
        stage = FactoryBot.build(:stage, theater: @theater, company: "")
        expect(stage).not_to be_valid
        expect(stage.errors[:company]).to include('を入力してください')
      end
    end
    
    context '一意であること' do
      it "作品と開演日の組み合わせが一意であること" do
        FactoryBot.create(:stage, theater: @theater)
        stage = Stage.new(theater: @theater, start_date: '2020-12-1')
        expect(stage).not_to be_valid
        expect(stage.errors[:theater_id]).to include('この作品は既に作成されています')
      end
    end
  end
end