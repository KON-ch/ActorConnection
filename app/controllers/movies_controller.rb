class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[show edit update destroy favorite]
  before_action :set_countries, only: %i[index new edit]

  def index
    if !params[:keyword].nil?
      @keyword = params[:keyword]
      display_movie(search_movie)
    elsif sort_params.present?
      sort_search
    elsif params[:country].present?
      sort_country(params[:country])
      display_movie(Movie.preload(:country, :reviews).where(country_id: @country))
    else
      display_movie(Movie.preload(:country, :reviews))
    end
    @sort_list = Movie.sort_list
    @movie = Movie.new
    @review = current_user.reviews.movies(@movies)
    like_movies = current_user.likees(Movie)
    @like_tags = like_movies.map(&:tag_ids).flatten!
    return if @like_tags.nil?
    tag = Tag.find(@like_tags.max_by{ |v| @like_tags.count(v) })
    @recommend_movie = tag.movies.where.not(id: like_movies.pluck(:id))
  end

  def show
    movie_reviews = @movie.reviews
    @reviews = movie_reviews.where.not(user: current_user)
    @new_review = @reviews.new
    @my_review = movie_reviews.find_by(user_id: current_user.id)
    @stages = Stage.limit(3)
    @review = Review.stages(@stages)
    @next = Movie.find_by(parent_id: @movie.id)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: '映画情報を登録しました'
    else
      redirect_to movies_path
      flash_alert
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: '映画情報を更新しました'
    else
      set_countries
      render :edit
      flash_alert
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: '映画情報を削除しました'
  end

  def favorite
    current_user.toggle_like!(@movie)
    @movie.reload
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :country_id, :production, :supervision,
                                  :sub_title, :screen_time, :quote_url, :synopsis, 
                                  :parent_id, :recommend, { tag_ids: [] }).merge(user_id: current_user.id)
  end

  def set_movie
    @movie = Movie.preload(:country).find(params[:id])
  end

  def set_countries
    @countries = Country.all
  end

  def sort_country(country)
    @country = Country.find(country.to_i)
  end

  def sort_params
    params.permit(:sort, :sort_country, :sort_keyword)
  end

  def search_movie
    Movie.preload(:country, :reviews).search_movies(@keyword)
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
      sort_country(sort_params[:sort_country])
      sort_movie(Movie.preload(:country, :reviews).where(country_id: @country))
    elsif sort_params[:sort_keyword].present?
      @keyword = sort_params[:sort_keyword]
      sort_movie(search_movie)
    else
      sort_movie(Movie)
    end
  end

  def flash_alert
    flash[:alert] = '正しく登録されませんでした'
  end
end
