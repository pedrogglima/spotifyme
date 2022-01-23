# frozen_string_literal: true

module Posts
  class AlbumsController < PrivateApplicationController
    def index
      @posts_albums = nil
    end
  end
end
