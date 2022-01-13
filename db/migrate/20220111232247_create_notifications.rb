# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :destinatary, null: false, foreign_key: { to_table: :users }, index: false
      t.references :notificable, polymorphic: true, null: false

      t.timestamps
    end
    add_index :notifications, %i[destinatary_id created_at]
    add_index :notifications, %i[destinatary_id notificable_type created_at],
              name: 'index_posts_on_user_id_and_postable_type_and_created_at'
  end
end
