class CreateNotificationsOfLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications_of_likes do |t|
      t.references :post, null: false, foreign_key: true, index: true
      t.string :content, null: false
      t.boolean :seen, null: false, default: false

      t.timestamps
    end
  end
end
