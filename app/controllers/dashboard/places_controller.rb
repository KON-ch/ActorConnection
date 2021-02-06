class Dashboard::PlacesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_place, only: %i[edit update destroy]
  layout 'dashboard/dashboard'

  def index
    @places = Place.all
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to dashboard_places_path, notice: '劇場情報を作成しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @place.update(place_params)
      redirect_to dashboard_places_path, notice: '劇場情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @place.destroy
    redirect_to dashboard_places_path, notice: '劇場情報を削除しました'
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address, :latitude, :longitude, :access)
  end
end
