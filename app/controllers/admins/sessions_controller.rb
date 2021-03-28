# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: %i[new create]

    # GET /resource/sign_in

    # POST /resource/sign_in

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    def after_sign_in_path_for(_user)
      dashboard_path
    end

    def after_sign_out_path_for(_user)
      root_path
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[name email password password_confirmation])
    end
  end
end
