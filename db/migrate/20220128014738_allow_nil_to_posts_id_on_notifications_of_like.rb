class AllowNilToPostsIdOnNotificationsOfLike < ActiveRecord::Migration[7.0]
  def change
    change_column :notifications_of_likes, :post_id, :bigint, null: true
  end
end
