class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]
  
  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      display_movie(search_movie)
    elsif sort_params.present?
      sort_search
    elsif params[:country].present?
      set_country(params[:country])
      display_movie(Movie.preload(:country).where(country_id: @country))
    else
      display_movie(Movie.preload(:country))
    end
    @sort_list = Movie.sort_list
    @movie = Movie.new
  end

  def show
    @reviews = @movie.reviews.preload(:user).where.not(user: current_user)
    @new_review = @reviews.new
    @my_review = @movie.reviews.find_by(user_id: current_user.id)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "映画情報を登録しました"
    else
      redirect_to movies_path
      flash_alert
    end
  end
  
  def edit
  end
  
  def update
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie), notice: "映画情報を更新しました" 
    else
      set_countries
      render :edit
      flash_alert
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "映画情報を削除しました" 
  end

  def favorite
    current_user.toggle_like!(@movie)
    @movie.reload
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :country_id, :production, :supervision, :sub_title).merge(user_id: current_user.id)
    end

    def set_movie
      @movie = Movie.preload(:country).find(params[:id])
    end

    def set_countries
      @countries = Country.all
    end

    def set_country(country)
      @country = Country.find(country.to_i)
    end

    def sort_params
      params.permit(:sort, :sort_country, :sort_keyword)
    end

    def search_movie
      Movie.preload(:country).search_movies(@keyword)
    end
  
    def total_count(movie)
      @total_count = movie.count
    end

    def display_movie(movie)
      @movies = movie.order(updated_at: :desc).display_list(params[:page])
      total_count(movie)
    end

    def sort_movie(movie)
      @movies = movie.sort_info(sort_params, params[:page])
      total_count(movie)
    end

    def sort_search
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        sort_movie(Movie.preload(:country).where(country_id: @country))
      elsif sort_params[:sort_keyword].present?
        @keyword = sort_params[:sort_keyword]
        sort_movie(search_movie)
      else
        sort_movie(Movie)
      end
    end

    def flash_alert
      flash[:alert] = "正しく登録されませんでした"
    end
end
