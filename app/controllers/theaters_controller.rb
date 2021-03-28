# frozen_string_literal: true

class TheatersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theater, only: %i[show edit update destroy favorite]
  before_action :set_countries, only: %i[index edit]

  def index
    if params[:keyword].present?
      @keyword = params[:keyword]
      display_theater(search_theater)
    elsif sort_params.present?
      sort_search
    elsif params[:country].present?
      sort_country(params[:country])
      display_theater(Theater.preload(:country, :reviews).where(country_id: @country))
    else
      display_theater(Theater.preload(:country, :reviews))
    end
    @sort_list = Theater.sort_list
    @theater = Theater.new
    @review = current_user.reviews.theaters(@theaters)
  end

  def show
    theater_reviews = @theater.reviews
    @reviews = theater_reviews.where.not(user: current_user)
    @new_review = @reviews.new
    @my_review = theater_reviews.find_by(user_id: current_user.id)
    stages = @theater.stages
    @review = Review.stages(stages)
  end

  def create
    @theater = Theater.new(theater_params)
    if @theater.save
      redirect_to theaters_path, notice: '戯曲情報を登録しました'
    else
      redirect_to theaters_path
      flash_alert
    end
  end

  def edit; end

  def update
    if @theater.update(theater_params)
      redirect_to theater_path(@theater), notice: '戯曲情報を更新しました'
    else
      set_countries
      render :edit
      flash_alert
    end
  end

  def destroy
    @theater.destroy
    redirect_to theaters_path, notice: '戯曲情報を削除しました'
  end

  def favorite
    current_user.toggle_like!(@theater)
    @theater.reload
  end

  private

  def theater_params
    params.require(:theater).permit(:title, :writer, :country_id, :man, :female).merge(user_id: current_user.id)
  end

  def set_theater
    @theater = Theater.preload(:country).find(params[:id])
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

  def search_theater
    Theater.preload(:country, :reviews).search_theaters(@keyword)
  end

  def total_count(theater)
    @total_count = theater.size
  end

  def display_theater(theater)
    @theaters = theater.order(updated_at: :desc).display_list(params[:page])
    total_count(theater)
  end

  def sort_theater(theater)
    @theaters = theater.sort_info(sort_params, params[:page])
    total_count(theater)
  end

  def sort_search
    if sort_params[:sort_country].present?
      sort_country(sort_params[:sort_country])
      sort_theater(Theater.preload(:country, :reviews).where(country_id: @country))
    elsif sort_params[:sort_keyword].present?
      @keyword = sort_params[:sort_keyword]
      sort_theater(search_theater)
    else
      sort_theater(Theater)
    end
  end

  def flash_alert
    flash[:alert] = '正しく登録されませんでした'
  end
end
