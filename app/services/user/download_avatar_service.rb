# frozen_string_literal: true

class User
  class DownloadAvatarService < ApplicationService
    def initialize(user_id)
      @user = ::User.find(user_id)
    end

    def call
      return if @user.account_images.blank?

      avatar_path = ::Download.on_tmp(@user.account_images.first)

      @user.avatar = File.open(avatar_path)
      @user.save
    end
  end
end
