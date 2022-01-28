class RemoveFkNotificationsOfLikeOnPosts < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :notifications_of_likes, :posts
  end
end
