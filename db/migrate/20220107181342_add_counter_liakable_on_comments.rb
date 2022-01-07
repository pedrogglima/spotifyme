# frozen_string_literal: true

class AddCounterLiakableOnComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :like_count, :counter_likeable
  end
end
