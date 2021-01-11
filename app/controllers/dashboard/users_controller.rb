class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "dashboard/dashboard"

  def index
    if params[:keyword] != nil
      @keyword = params[:keyword]
      @users = search_user.display_list(params[:pages])
      total_count(search_user)
    else
      if sort_params.present?
        @users = User.sort_info(sort_params, params[:page])
        total_count(User)
      else
        @users = User.display_list(params[:page])
        total_count(User)
      end
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

  def total_count(user)
    @total_count = user.count
  end

end
