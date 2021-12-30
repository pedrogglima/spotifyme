# frozen_string_literal: true

class CreateFollowInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_invitations do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }, index: false
      t.references :following, null: false, foreign_key: { to_table: :users }, index: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :follow_invitations, %i[follower_id following_id], unique: true
    add_index :follow_invitations,
              %i[follower_id following_id status],
              name: 'index_follow_invitations_on_follower_id_following_id_status'
    add_index :follow_invitations,
              %i[following_id follower_id status],
              name: 'index_follow_invitations_on_following_id_follower_id_status'
  end
end
