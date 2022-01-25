class CreatePostsTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_tracks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :played_at, null: false
      t.integer :duration_ms
      t.integer :popularity
      t.string :track_url
      t.string :album_name, null: false
      t.string :album_url
      t.string :artists_name, array: true, default: []
      t.string :artists_url, array: true, default: []
      t.text :image_data
      t.integer :counter_likeable, default: 0

      t.timestamps
    end
    add_index :posts_tracks, %i[user_id played_at]
  end
end
