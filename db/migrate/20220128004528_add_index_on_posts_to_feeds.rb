class AddIndexOnPostsToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_index :feeds, :post_id
  end
end
