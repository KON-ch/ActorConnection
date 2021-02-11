class StagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stage, only: %i[show edit update destroy favorite]
  before_action :set_theaters, only: %i[index new edit]
  before_action :set_places, only: %i[index new edit]

  def index
    @stages = if sort_params.present?
                Stage.preload(:theater, :reviews).this_month.sort_info(sort_params, params[:page])
              elsif params[:date] == 'last_month'
                Stage.preload(:theater, :reviews).last_month.order(updated_at: :desc).display_list(params[:page])
              elsif params[:date] == 'next_month'
                Stage.preload(:theater, :reviews).next_month.order(updated_at: :desc).display_list(params[:page])
              elsif params[:date] == 'this_month'
                Stage.preload(:theater, :reviews).this_month.order(updated_at: :desc).display_list(params[:page])
              else
                Stage.preload(:theater, :reviews).order(updated_at: :desc).display_list(params[:page])
              end
    @sort_list = Stage.sort_list
    @stage = Stage.new
    @review = current_user.reviews.stages(@stages)
  end

  def show
    stage_reviews = @stage.reviews.preload(:user)
    @reviews = stage_reviews.where.not(user: current_user)
    @new_review = @reviews.new
    @my_review = stage_reviews.find_by(user: current_user)
    @lat = @stage.place.latitude
    @lng = @stage.place.longitude
    @movies = Movie.limit(3)
    @review = Review.movies(@movies)
  end

  def new
    @stage = Stage.new
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to stages_path, notice: '公演情報を登録しました'
    else
      redirect_to stages_path
      flash_alert
    end
  end

  def edit; end

  def update
    if @stage.update(stage_params)
      redirect_to stage_path(@stage), notice: '公演情報を更新しました'
    else
      set_theaters
      set_places
      render :edit
      flash_alert
    end
  end

  def destroy
    @stage.destroy
    redirect_to stages_path, notice: '公演情報を削除しました'
  end

  def favorite
    current_user.toggle_like!(@stage)
    @stage.reload
  end

  private

  def stage_params
    params.require(:stage).permit(:start_date, :end_date, :company, :theater_id,
                                  :place_id, :synopsis, :matinee, :soiree, { :soiree_ids => [] }).merge(user_id: current_user.id)
  end

  def set_stage
    @stage = Stage.preload(:place, :theater).find(params[:id])
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
