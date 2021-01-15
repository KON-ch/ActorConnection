class TheatersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theater, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]

  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      @theaters = search_theater.display_list(params[:pages])
      total_count(search_theater)
    elsif sort_params.present?
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        @theaters = Theater.country_theaters(sort_params[:sort_country]).sort_info(sort_params, params[:page])
        total_count(Theater.country_theaters(sort_params[:sort_country]))
      elsif params[:sort_keyword].present?
        @keyword = params[:sort_keyword]
        @theaters = search_theater.sort_info(sort_params, params[:page])
        total_count(search_theater)
      else
        @theaters = Theater.sort_info(sort_params, params[:page])
        total_count(Theater)
      end
    elsif params[:country].present?
      set_country(params[:country])
      @theaters = Theater.country_theaters(@country).display_list(params[:page])
      total_count(Theater.country_theaters(@country))
    else
      @theaters = Theater.display_list(params[:page])
      total_count(Theater)
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
      params.require(:theater).permit(:title, :writer, :country_id, :man, :female).merge(user_id: current_user.id)
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
      Theater.where("title LIKE ? OR writer LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end
  
    def total_count(theater)
      @total_count = theater.count
    end

end
