# frozen_string_literal: true

class AddInfoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_type, :string
    add_column :users, :nickname, :string, null: false
    add_column :users, :birthdate, :datetime
    add_column :users, :country, :string
    add_column :users, :account_product, :string
    add_column :users, :account_images, :string, array: true, default: []
  end
end
