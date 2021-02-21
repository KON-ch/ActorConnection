# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user.present? && !user.deleted_flg?
      super
      return
    end
    redirect_to webs_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest
    user = User.new_guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  def after_sign_in_path_for(_user)
    root_path
  end

  def after_sign_out_path_for(_user)
    root_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in,
                                      keys: %i[name birthday sex password password_confirmatin profile])
  end
end
