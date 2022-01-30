class AddSpotifyHashToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spotify_credentials, :json, default: {}
  end
end
