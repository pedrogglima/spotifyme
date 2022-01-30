# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def spotify
      @user = User.from_omniauth(from_provider_params)
      @user.spotify_credentials = { "credentials": auth.credentials.to_h }

      if @user.save
        sign_out_all_scopes
        flash_message_success
        sign_in_and_redirect @user, event: :authentication
      else
        logger.error "User.from_omniauth failed: #{@user.errors.full_messages}"
        flash_message_failure
        redirect_to new_user_session_url
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      root_path
    end

    private

    def flash_message_success
      flash[:notice] = t 'devise.omniauth_callbacks.success'
    end

    def flash_message_failure
      flash[:alert] = t 'devise.omniauth_callbacks.failure',
                        reason: 'Something went wrong.'
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
        account_country: auth.country,
        account_product: auth.product,
        account_images: user_avatar,
        current_sign_in_ip: request.remote_ip,
        spotify_credentials: auth.to_hash
      }
    end

    def auth
      @auth ||= RSpotify::User.new(request.env['omniauth.auth'])
    end

    def user_avatar
      return [] unless auth.images.present? &&
                       auth.images.is_a?(Array)

      [auth.images.first[:url]]
    end
  end
end
