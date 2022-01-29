# frozen_string_literal: true

module Track
  class DownloadImageService < ApplicationService
    def initialize(track_id)
      @track = ::Posts::Track.find(track_id)
    end

    def call
      return if @track.image_url.nil?

      image_path = ::Download.on_tmp(@track.spotify_image_url)

      @track.image = File.open(image_path)
      @track.save
    end
  end
end
