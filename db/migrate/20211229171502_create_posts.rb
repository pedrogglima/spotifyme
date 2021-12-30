# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :postable, polymorphic: true, null: false

      t.timestamps
    end
    add_index :posts, %i[user_id created_at]
  end
end
