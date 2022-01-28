class AddDeletedToPostables < ActiveRecord::Migration[7.0]
  def change
    add_column :posts_users, :deleted, :boolean, default: false
    add_column :posts_tracks, :deleted, :boolean, default: false
    add_column :posts_albums, :deleted, :boolean, default: false

    add_index :posts_users, %i[user_id deleted created_at],
              name: 'index_posts_users_on_user_id_and_deleted_and_created_at'
    add_index :posts_tracks, %i[user_id deleted created_at],
              name: 'index_posts_tracks_on_user_id_and_deleted_and_created_at'
    add_index :posts_tracks, %i[user_id deleted played_at],
              name: 'index_posts_tracks_on_user_id_and_deleted_and_played_at'
    add_index :posts_albums, %i[user_id deleted created_at],
              name: 'index_posts_albums_on_user_id_and_deleted_and_played_at'

    remove_index :posts_users, :user_id
    remove_index :posts_tracks, :user_id
    remove_index :posts_tracks, %i[user_id created_at]
    remove_index :posts_tracks, %i[user_id played_at]
    remove_index :posts_albums, :user_id
  end
end
