class Dashboard::StagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_stage, only: [:edit, :update, :destroy]
  before_action :set_theaters, only: [:new, :edit]
  before_action :set_places, only: [:new, :edit]
  layout "dashboard/dashboard"

  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      @stages = search_stage.display_list(params[:pages])
      total_count(search_stage)
    else
      if sort_params.present?
        @stages = Stage.sort_info(sort_params, params[:page])
        total_count(Stage)
      else
        @stages = Stage.display_list(params[:page])
        total_count(Stage)
      end
    end

    @sort_list = Stage.sort_list
  end

  def new
    @stage = Stage.new
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to dashboard_stages_path, notice: "公演情報を作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @stage.update_attributes(stage_params)
      redirect_to dashboard_stages_path, notice: "公演情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @stage.destroy
    redirect_to dashboard_stages_path
  end

  private
    def stage_params
      params.require(:stage).permit(:start_date, :end_date, :company, :theater_id, :place_id).merge(user_id: current_admin.id)
    end

    def set_stage
      @stage = Stage.find(params[:id])
    end

    def set_theaters
      @theaters = Theater.all
    end

    def set_places
      @places = Place.all
    end

    def sort_params
      params.permit(:sort)
    end

    def search_stage
      Stage.where("company LIKE ?", "%#{@keyword}%")
    end

    def total_count(stage)
      @total_count = stage.count
    end
end
