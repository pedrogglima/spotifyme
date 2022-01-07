# frozen_string_literal: true

class ChangePostTypeSimpleToPostsUser < ActiveRecord::Migration[7.0]
  def change
    rename_table :post_type_simples, :posts_users
  end
end
