# frozen_string_literal: true

module Dashboard
  class CountriesController < ApplicationController
    before_action :authenticate_admin!
    layout 'dashboard/dashboard'

    def index
      @countries = Country.all
      @country = Country.new
    end

    def create
      country = Country.new(country_params)
      country.save
      redirect_to dashboard_countries_path
    end

    def destroy
      country = Country.find(params[:ie])
      country.destroy
      redirect_to dashboard_countries_path
    end

    private

    def country_params
      params.require(:country).permit(:name)
    end
  end
end
