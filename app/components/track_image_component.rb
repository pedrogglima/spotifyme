# frozen_string_literal: true

class TrackImageComponent < ViewComponent::Base
  def initialize(track:, trackname: 'T', style: 'w-120 h-120', size: :medium)
    @track = normalize_track(track)
    @trackname = trackname
    @style = style
    @size = size
  end

  def normalize_track(track)
    track.is_a?(String) ? Posts::Track.new(image_data: track) : track
  end

  def picture?
    @track.present? && @track.is_a?(Posts::Track) && @track.image_data.present?
  end

  def first_letter
    @trackname.first.upcase
  end
end
