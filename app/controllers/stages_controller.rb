class StagesController < ApplicationController
  before_action :set_stage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if sort_params.present?
      @stages = Stage.sort_order(sort_params, params[:page])
    else
      @stages = Stage.display_list(params[:page])
    end
    @sort_list = Stage.sort_list
  end

  def show
  end

  def new
    @stage = Stage.new
    @theaters = Theater.all
    @places = Place.all
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to stages_path, notice: "公演情報を作成しました"
    else
      render :new
    end
  end

  def edit
    @theaters = Theater.all
    @places = Place.all
  end

  def update
    @stage.update(stage_params)
    redirect_to stages_path, notice: "公演情報を更新しました"
  end

  def destroy
    @stage.destroy
    redirect_to stages_path
  end

  private
    def stage_params
      params.require(:stage).permit(:start_date, :end_date, :company, :theater_id, :place_id).merge(user_id: current_user.id)
    end

    def set_stage
      @stage = Stage.find(params[:id])
    end

    def sort_params
      params.permit(:sort)
    end
end
