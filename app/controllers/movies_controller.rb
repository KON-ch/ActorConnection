class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]
  
  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      display_movie(search_movie)
    elsif sort_params.present?
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        sort_movie(Movie.country_movies(sort_params[:sort_country]))
      elsif params[:sort_keyword].present?
        @keyword = params[:sort_keyword]
        sort_movie(search_movie)
      else
        sort_movie(Movie)
      end
    elsif params[:country].present?
      set_country(params[:country])
      display_movie(Movie.country_movies(@country))
    else
      display_movie(Movie)
    end
    @sort_list = Movie.sort_list
  end

  def show
    @reviews = @movie.reviews
    @review = @reviews.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "映画情報を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie), notice: "映画情報を更新しました" 
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "映画情報を削除しました" 
  end

  def favorite
    current_user.toggle_like!(@movie)
    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :country_id, :production, :supervision, :sub_title).merge(user_id: current_user.id)
    end

    def set_movie
      @movie = Movie.find(params[:id])
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

    def search_movie
      Movie.search_movies(@keyword)
    end
  
    def total_count(movie)
      @total_count = movie.count
    end

    def display_movie(movie)
      @movies = movie.display_list(params[:pages])
      total_count(movie)
    end

    def sort_movie(movie)
      @movies = movie.sort_info(sort_params, params[:page])
      total_count(movie)
    end
end
