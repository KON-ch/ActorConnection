class TheatersController < ApplicationController
  before_action :set_theater, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]
  before_action :authenticate_user!

  def index
    if sort_params.present?
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        @theaters = Theater.where(country_id: sort_params[:sort_country]).sort_info(sort_params, params[:page])
      else
        @theaters = Theater.sort_info(sort_params, params[:page])
      end
    elsif params[:country].present?
      set_country(params[:country])
      @theaters = Theater.country_theaters(@country, params[:page])
    else
      @theaters = Theater.display_list(params[:page])
    end
    @sort_list = Theater.sort_list
  end

  def show
    @reviews = @theater.reviews
    @review = @reviews.new
  end

  def new
    @theater = Theater.new
  end

  def create
    @theater = Theater.new(theater_params)
    if @theater.save
      redirect_to theaters_path, notice: "新しい戯曲を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @theater.update_attributes(theater_params)
      redirect_to theater_path(@theater), notice: "戯曲情報を修正しました" 
    else
      render :edit
    end
  end

  def destroy
    @theater.destroy
    redirect_to theaters_path
  end

  def favorite
    current_user.toggle_like!(@theater)
    redirect_to theaters_path
  end

  private
    def theater_params
      params.require(:theater).permit(:title, :writer, :country_id, :man, :female, :translator, :include, :publication).merge(user_id: current_user.id)
    end

    def set_theater
      @theater = Theater.find(params[:id])
    end

    def set_countries
      @countries = Country.all
    end

    def set_country(country)
      @country = Country.request_country(country)
    end

    def sort_params
      params.permit(:sort, :sort_country)
    end

end
