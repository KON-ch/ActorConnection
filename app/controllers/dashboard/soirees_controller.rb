class Dashboard::SoireesController < ApplicationController
  layout 'dashboard/dashboard'

  def index
    @soirees = Soiree.all.order(performance_date: :desc)
    @soiree_new = Soiree.new
  end

  def create
    @soiree = Soiree.new(soiree_params)
    @soiree.save
    redirect_to dashboard_soirees_path
  end

  def destroy
    soiree = Soiree.find(params[:id])
    soiree.destroy
    redirect_to dashboard_soirees_path
  end

  private

  def soiree_params
    params.require(:soiree).permit(:performance_date)
  end
end
