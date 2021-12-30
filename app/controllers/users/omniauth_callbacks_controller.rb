# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def spotify
      @user = User.from_omniauth(from_provider_params)
      if @user.persisted?
        sign_out_all_scopes
        flash_message_success('Twitter')
        sign_in_and_redirect @user, event: :authentication
      else
        flash_message_failure('Twitter', auth.info.email)
        redirect_to new_user_session_url
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      root_path
    end

    private

    def flash_message_success(kind)
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: kind
    end

    def flash_message_failure(kind, email)
      flash[:alert] = t 'devise.omniauth_callbacks.failure',
                        kind: kind,
                        reason: "#{email} não está autorizado."
    end

    def from_provider_params
      @from_provider_params ||= {
        # TODO: PR RSpotify::User to accept provider and uid
        provider: request.env['omniauth.auth']['provider'],
        uid: request.env['omniauth.auth']['uid'],
        account_type: auth.type,
        nickname: auth.display_name,
        email: auth.email,
        # birthdate: auth.birthdate,
        country: auth.country,
        account_product: auth.product,
        account_images: auth.images.present? ? auth.images.first.url : nil
      }
    end

    def auth
      @auth ||= RSpotify::User.new(request.env['omniauth.auth'])
    end
  end
end
