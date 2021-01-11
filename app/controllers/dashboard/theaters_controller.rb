class Dashboard::TheatersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_theater, only: [:edit, :update, :destroy]
  layout "dashboard/dashboard"

  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      @theaters = search_theater.display_list(params[:pages])
      total_count(search_theater)
    else
      if sort_params.present?
        @theaters = Theater.sort_info(sort_params, params[:page])
        total_count(Theater)
      else
        @theaters = Theater.display_list(params[:page])
        total_count(Theater)
      end
    end

    @sort_list = Theater.sort_list
  end

  def new
    @theater = Theater.new
  end

  def create
    @theater = Theater.new(theater_params)
    if @theater.save
      redirect_to dashboard_theaters_path, notice: "新しい戯曲を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @theater.update_attributes(theater_params)
      redirect_to dashboard_theaters_path, notice: "戯曲情報を修正しました" 
    else
      render :edit
    end
  end

  def destroy
    @theater.destroy
    redirect_to dashboard_theaters_path
  end

  private
  def theater_params
    params.require(:theater).permit(:title, :writer, :country, :man, :female, :translator, :include, :publication).merge(user_id: current_admin.id)
  end

  def set_theater
    @theater = Theater.find(params[:id])
  end

  def sort_params
    params.permit(:sort)
  end

  def search_theater
    Theater.where("title LIKE ? OR writer LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
  end

  def total_count(theater)
    @total_count = theater.count
  end
end
