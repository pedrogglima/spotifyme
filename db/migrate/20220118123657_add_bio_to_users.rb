class AddBioToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :profile_url, :string
    rename_column :users, :country, :account_country
    add_column :users, :country, :string
    add_column :users, :state, :string
  end
end
