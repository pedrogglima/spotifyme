# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.references :post, null: false, foreign_key: true, index: false
      t.references :user, null: false, foreign_key: true, index: false
      t.boolean :visiable, null: false, default: true

      t.timestamps
    end
    add_index :feeds, %i[user_id visiable created_at]
  end
end
