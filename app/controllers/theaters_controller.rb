class TheatersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theater, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]

  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      display_theater(search_theater)
    elsif sort_params.present?
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        sort_theater(Theater.country_theaters(sort_params[:sort_country]))
      elsif params[:sort_keyword].present?
        @keyword = params[:sort_keyword]
        sort_theater(search_theater)
      else
        sort_theater(Theater)
      end
    elsif params[:country].present?
      set_country(params[:country])
      display_theater(Theater.country_theaters(@country))
    else
      display_theater(Theater)
    end
    @sort_list = Theater.sort_list
  end

  def show
  end

  def new
    @theater = Theater.new
  end

  def create
    @theater = Theater.new(theater_params)
    if @theater.save
      redirect_to theaters_path, notice: "戯曲情報を登録しました"
    else
      @countries = Country.all
      render :new
    end
  end

  def edit
  end

  def update
    if @theater.update_attributes(theater_params)
      redirect_to theater_path(@theater), notice: "戯曲情報を更新しました" 
    else
      render :edit
    end
  end

  def destroy
    @theater.destroy
    redirect_to theaters_path
  end

  def favorite
    @post = Post.find_by(theater_id: @theater.id)
    current_user.toggle_like!(@post)
  end

  private
    def theater_params
      params.require(:theater).permit(:title, :writer, :country_id, :man, :female)
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

    def search_theater
      Theater.search_theaters(@keyword)
    end
  
    def total_count(theater)
      @total_count = theater.count
    end

    def display_theater(theater)
      @theaters = theater.display_list(params[:page])
      total_count(theater)
    end

    def sort_theater(theater)
      @theaters = theater.sort_info(sort_params, params[:page])
        total_count(theater)
    end

end
