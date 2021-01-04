class TheatersController < ApplicationController
  before_action :set_theater, only: [:show, :edit, :update, :destroy, :favorite]

  def index
    @theaters = Theater.all
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
    @theater.update(theater_params)
    redirect_to theater_path(@theater), notice: "戯曲情報を修正しました" 
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
      params.require(:theater).permit(:title, :writer, :country, :man, :female, :translator, :include, :publication)
    end

    def set_theater
      @theater = Theater.find(params[:id])
    end
end
