# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false, index: false
      t.references :user, null: false, foreign_key: true, index: false
      t.text :content, null: false
      t.integer :like_count, null: false, default: 0

      t.timestamps
    end
    add_index :comments,
              %i[commentable_type commentable_id created_at],
              name: 'index_comments_on_commentable_type_commentable_id_created_at'
  end
end
