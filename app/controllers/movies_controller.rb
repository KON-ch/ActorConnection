class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :set_countries, only: [:index, :new, :edit]
  
  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      @movies = search_movie.display_list(params[:pages])
      total_count(search_movie)
    elsif sort_params.present?
      if sort_params[:sort_country].present?
        set_country(sort_params[:sort_country])
        @movies = Movie.country_movies(sort_params[:sort_country]).sort_info(sort_params, params[:page])
        total_count(Movie.country_movies(sort_params[:sort_country]))
      elsif params[:sort_keyword].present?
        @keyword = params[:sort_keyword]
        @movies = search_movie.sort_info(sort_params, params[:page])
        total_count(search_movie)
      else
        @movies = Movie.sort_info(sort_params, params[:page])
        total_count(Theater)
      end
    elsif params[:country].present?
      set_country(params[:country])
      @movies = Movie.country_movies(@country).display_list(params[:page])
      total_count(Movie.country_movies(@country))
    else
      @movies = Movie.display_list(params[:page])
      total_count(Movie)
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
      redirect_to movies_path, notice: "新しい映画を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie), notice: "映画情報を修正しました" 
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
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
      params.permit(:sort)
    end

    def search_movie
      Movie.where("title LIKE ? OR supervision LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end
  
    def total_count(movie)
      @total_count = movie.count
    end
end
