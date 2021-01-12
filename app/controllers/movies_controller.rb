class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :authenticate_user!
  
  PER = 3

  def index
    if sort_params.present?
      @movies = Movie.sort_info(sort_params, params[:page])
    else
      @movies = Movie.display_list(params[:page])
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
      params.require(:movie).permit(:title, :country, :production, :viewing, :supervision, :sub_title).merge(user_id: current_user.id)
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def sort_params
      params.permit(:sort)
    end
end
