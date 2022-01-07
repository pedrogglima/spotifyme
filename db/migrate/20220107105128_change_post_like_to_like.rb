# frozen_string_literal: true

class ChangePostLikeToLike < ActiveRecord::Migration[7.0]
  def change
    rename_table :post_likes, :likes
  end
end
