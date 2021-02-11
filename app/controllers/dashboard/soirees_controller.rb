class Dashboard::SoireesController < ApplicationController
  def index
    @soirees = Soiree.all
    @soiree_new = Soiree.new
  end
  
  def create
    @soiree = Soiree.new(soiree_params)
    if @soiree.save
      redirect_to dashboard_soirees_path, notice: "登録しました"
    else
      render :index, notice: "失敗しました"
    end
  end

  private
    def soiree_params
      params.require(:soiree).permit(:performance_date)
    end
end
