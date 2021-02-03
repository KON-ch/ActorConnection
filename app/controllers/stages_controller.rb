class StagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stage, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_theaters, only: [:index, :new, :edit]
  before_action :set_places, only: [:index, :new, :edit]

  def index
    if sort_params.present?
      @stages = Stage.where("extract(month from end_date) = ?", Date.today.month).sort_info(sort_params, params[:page])
    elsif params[:date] == "last_month"
      @stages= Stage.where("extract(month from end_date) = ?", Date.current.last_month.month).order(updated_at: :desc).display_list(params[:page])
    elsif params[:date] == "next_month"
      @stages= Stage.where("extract(month from end_date) = ?", Date.current.next_month.month).order(updated_at: :desc).display_list(params[:page])
    elsif params[:date] == "this_month"
      @stages= Stage.where("extract(month from end_date) = ?", Date.current.month).or(Stage.where("extract(month from end_date) = ?", Date.current.month)).order(updated_at: :desc).display_list(params[:page])
    else
      @stages = Stage.order(updated_at: :desc).display_list(params[:page])
    end
    @sort_list = Stage.sort_list
  end
  
  def show
    @reviews = @stage.reviews.includes(:user).where.not(user: current_user)
    @review = @reviews.new
    @my_review = @stage.reviews.find_by(user_id: current_user.id)
    @lat = @stage.place.latitude
    @lng = @stage.place.longitude
  end
  
  def new
    @stage = Stage.new
  end
  
  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to stages_path, notice: "公演情報を登録しました"
    else
      @theaters = Theater.all
      @places = Place.all
      @stages = Stage.where('extract(month from end_date) = ?', Date.today.month).order(updated_at: :desc).display_list(params[:page])
      @sort_list = Stage.sort_list
      render :index
    end
  end
  
  def edit
  end
  
  def update
    if @stage.update_attributes(stage_params)
      redirect_to stages_path, notice: "公演情報を更新しました"
    else
      @theaters = Theater.all
      @places = Place.all
      render :edit
    end
  end

  def destroy
    @stage.destroy
    redirect_to stages_path, notice: "公演情報を削除しました"
  end

  def favorite
    current_user.toggle_like!(@stage)
    @stage.reload
  end

  private
    def stage_params
      params.require(:stage).permit(:start_date, :end_date, :company, :theater_id, :place_id).merge(user_id: current_user.id)
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

end
