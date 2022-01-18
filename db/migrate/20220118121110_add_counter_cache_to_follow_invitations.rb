class AddCounterCacheToFollowInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :counter_follower, :integer, default: 0
    add_column :users, :counter_following, :integer, default: 0
  end
end
