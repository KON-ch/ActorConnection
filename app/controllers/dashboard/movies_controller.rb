class Dashboard::MoviesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_movie, only: [:edit, :update, :destroy]
  layout "dashboard/dashboard"

  def index
    if params[:keyword] != nil
        @keyword = params[:keyword]
        @movies = search_movie.display_list(params[:pages])
        total_count(search_movie)
    else
      if sort_params.present?
        @movies = Movie.sort_info(sort_params, params[:page])
        total_count(Movie)
      else
        @movies = Movie.display_list(params[:page])
        total_count(Movie)
      end
    end

    @sort_list = Movie.sort_list
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to dashboard_movies_path, notice: "新しい映画を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @moive.update_attributes(movie_params)
      redirect_to dashboard_movies_path, notice: "映画情報を修正しました" 
    else
      render :edit
    end
  end

  def destroy
    @moive.destroy
    redirect_to dashboard_movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :country, :production, :viewing).merge(user_id: current_admin.id)
  end

  def set_theater
    @movie = Movie.find(params[:id])
  end

  def sort_params
    params.permit(:sort)
  end

  def search_movie
    Movie.where("title LIKE ?", "%#{@keyword}%")
  end

  def total_count(movie)
    @total_count = movie.count
  end
end
