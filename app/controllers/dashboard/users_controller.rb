class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "dashboard/dashboard"

  def index
    if sort_params.present?
      @users = User.sort_order(sort_params, params[:page])
    else
      @users = User.display_list(params[:page])
    end

    if params[:keyword] != nil
      @keyword = params[:keyword]
      @users = search_user.display_list(params[:pages])
      @total_count = search_user.count
    else
      @total_count = User.count
      @users = User.display_list(params[:page])
    end

    @sort_list = User.sort_list
  end

  def destroy
    user = User.find(params[:id])
    user.deleted_flg = User.switch_flg(user.deleted_flg)
    user.save
    redirect_to dashboard_users_path
  end

  private
  def sort_params
    params.permit(:sort)
  end

  def search_user
    User.where("name LIKE ? OR email LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
  end

end
