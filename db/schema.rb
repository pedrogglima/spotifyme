# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_211_229_174_112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.string 'commentable_type', null: false
    t.bigint 'commentable_id', null: false
    t.bigint 'user_id', null: false
    t.text 'content', null: false
    t.integer 'like_count', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[commentable_type commentable_id created_at],
            name: 'index_comments_on_commentable_type_commentable_id_created_at'
  end

  create_table 'feeds', force: :cascade do |t|
    t.bigint 'post_id', null: false
    t.bigint 'user_id', null: false
    t.boolean 'visiable', default: true, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[user_id visiable created_at], name: 'index_feeds_on_user_id_and_visiable_and_created_at'
  end

  create_table 'follow_invitations', force: :cascade do |t|
    t.bigint 'follower_id', null: false
    t.bigint 'following_id', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[follower_id following_id status],
            name: 'index_follow_invitations_on_follower_id_following_id_status'
    t.index %w[follower_id following_id], name: 'index_follow_invitations_on_follower_id_and_following_id',
                                          unique: true
    t.index %w[following_id follower_id status],
            name: 'index_follow_invitations_on_following_id_follower_id_status'
  end

  create_table 'post_likes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'likeable_type', null: false
    t.bigint 'likeable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[likeable_type likeable_id], name: 'index_post_likes_on_likeable'
    t.index ['user_id'], name: 'index_post_likes_on_user_id'
  end

  create_table 'post_type_simples', force: :cascade do |t|
    t.text 'content', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'posts', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'postable_type', null: false
    t.bigint 'postable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[postable_type postable_id], name: 'index_posts_on_postable'
    t.index %w[user_id created_at], name: 'index_posts_on_user_id_and_created_at'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at', precision: 6
    t.datetime 'remember_created_at', precision: 6
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'provider', null: false
    t.string 'uid', null: false
    t.string 'account_type'
    t.string 'nickname', null: false
    t.datetime 'birthdate', precision: 6
    t.string 'country'
    t.string 'account_product'
    t.string 'account_images', default: [], array: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index %w[provider uid], name: 'index_users_on_provider_and_uid', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'comments', 'users'
  add_foreign_key 'feeds', 'posts'
  add_foreign_key 'feeds', 'users'
  add_foreign_key 'follow_invitations', 'users', column: 'follower_id'
  add_foreign_key 'follow_invitations', 'users', column: 'following_id'
  add_foreign_key 'post_likes', 'users'
  add_foreign_key 'posts', 'users'
end
