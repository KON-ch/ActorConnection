module Dashboard
  class MatineesController < ApplicationController
    layout 'dashboard/dashboard'

    def index
      @matinees = Matinee.all.order(performance_date: :asc)
      @matinee_new = Matinee.new
    end

    def create
      @matinee = Matinee.new(matinee_params)
      @matinee.save
      redirect_to dashboard_matinees_path
    end

    def destroy
      matinee = Matinee.find(params[:id])
      matinee.destroy
      redirect_to dashboard_matinees_path
    end

    private

    def matinee_params
      params.require(:matinee).permit(:performance_date)
    end
  end
end
