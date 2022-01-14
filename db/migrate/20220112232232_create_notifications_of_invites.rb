class CreateNotificationsOfInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications_of_invites do |t|
      t.string :content, null: false
      t.boolean :seen, null: false, default: false

      t.timestamps
    end
  end
end
