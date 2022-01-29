class AddImageUrlsToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :posts_tracks, :spotify_image_urls, :string, array: true, default: []
  end
end
