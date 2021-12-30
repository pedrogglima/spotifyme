# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]
    before_action :if_sign_in_redirect_to, only: [:show]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    def show; end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out

    protected

    def if_sign_in_redirect_to
      redirect_to feeds_path if current_user
    end

    def after_sign_out_path_for(_resource_or_scope)
      root_path
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
