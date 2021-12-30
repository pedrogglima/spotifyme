# frozen_string_literal: true

class AddConstrainOmniauthUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :provider, false
    change_column_null :users, :uid, false
  end
  add_index :users, %i[provider uid], unique: true
end
