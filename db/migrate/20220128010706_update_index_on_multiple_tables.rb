class UpdateIndexOnMultipleTables < ActiveRecord::Migration[7.0]
  def change
    remove_index :feeds, :post_id
    remove_index :posts, %i[user_id created_at]
    remove_index :follow_invitations, %i[follower_id following_id status]
    remove_index :follow_invitations, %i[following_id follower_id status]

    add_index :likes, %i[likeable_type likeable_id user_id]
    add_index :follow_invitations, %i[follower_id following_id status created_at],
              name: 'index_follow_inv_on_follower_id_following_id_status_created_at'
    add_index :follow_invitations, %i[following_id follower_id status created_at],
              name: 'index_follow_inv_on_following_id_follower_id_status_created_at'
  end
end
