class AddUserToPostsUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts_users, :user, null: false, foreign_key: true, index: %i[user_id created_at]
  end
end
