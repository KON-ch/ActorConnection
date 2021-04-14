class Dashboard::PlicesController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'
  def index
    @plices = Plice.all
    @plice_new = Plice.new
  end

  def create
    plice = Plice.new(plice_params)
    if plice.save
      redirect_to dashboard_plices_path
      flash[:notice] = '新しい料金を作成しました'
    else
      redirect_to dashboard_plices_path
      flash[:alert] = '登録に失敗しました'
    end
  end

  def destroy
    plice = Plice.find(params[:id])
    plice.destroy
    redirect_to dashboard_plices_path
  end

  private

  def plice_params
    params.require(:plice).permit(:name, :fee)
  end
end
