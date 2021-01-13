class Dashboard::CountriesController < ApplicationController
  before_action :authenticate_admin!
  layout "dashboard/dashboard"

  def index
    @countries = Country.all
    @country = Country.new
  end

  def create
    country = Country.new(country_params)
    if country.save
      redirect_to dashboard_countries_path
    else
      render :new
    end
  end

  private
    def country_params
      params.require(:country).permit(:name)
    end
end
