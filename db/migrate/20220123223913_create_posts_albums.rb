class CreatePostsAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_albums do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :album_url
      t.integer :popularity
      t.integer :track_number
      t.datetime :release_date
      t.text :image_data
      t.integer :counter_likeable, default: 0

      t.timestamps
    end
    add_index :posts_tracks, %i[user_id created_at]
  end
end
