# frozen_string_literal: true

class UsersController < PrivateApplicationController
  def index
    if params[:uid].present?
      @user = User.find_by(provider: 'spotify',
                           uid: uid_formatted)

      begin
        # TODO: may save spotify user data to db
        @spotify_user = RSpotify::User.find(uid_formatted) unless @user
      rescue RestClient::NotFound
        # do nothing
      rescue RestClient::BadRequest
      # treat exception
      rescue SocketError
        # treat exception
      end
    end

    render :index
  end

  private

  def uid_formatted
    @uid_formatted ||= params[:uid].to_s.delete_prefix('@')
  end
end
