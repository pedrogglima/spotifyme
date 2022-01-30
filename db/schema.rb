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

ActiveRecord::Schema.define(version: 2022_01_30_192700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.integer "counter_likeable", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id", "created_at"], name: "index_comments_on_commentable_type_commentable_id_created_at"
  end

  create_table "feeds", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.boolean "visiable", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "visiable", "created_at"], name: "index_feeds_on_user_id_and_visiable_and_created_at"
  end

  create_table "follow_invitations", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "following_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "following_id", "status", "created_at"], name: "index_follow_inv_on_follower_id_following_id_status_created_at"
    t.index ["follower_id", "following_id"], name: "index_follow_invitations_on_follower_id_and_following_id", unique: true
    t.index ["following_id", "follower_id", "status", "created_at"], name: "index_follow_inv_on_following_id_follower_id_status_created_at"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_type", "likeable_id", "user_id"], name: "index_likes_on_likeable_type_and_likeable_id_and_user_id"
    t.index ["likeable_type", "likeable_id"], name: "index_post_likes_on_likeable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "destinatary_id", null: false
    t.string "notificable_type", null: false
    t.bigint "notificable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destinatary_id", "created_at"], name: "index_notifications_on_destinatary_id_and_created_at"
    t.index ["destinatary_id", "notificable_type", "created_at"], name: "index_posts_on_user_id_and_postable_type_and_created_at"
    t.index ["notificable_type", "notificable_id"], name: "index_notifications_on_notificable"
  end

  create_table "notifications_of_invites", force: :cascade do |t|
    t.string "content", null: false
    t.boolean "seen", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications_of_likes", force: :cascade do |t|
    t.bigint "post_id"
    t.string "content", null: false
    t.boolean "seen", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_notifications_of_likes_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "postable_type", null: false
    t.bigint "postable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable"
  end

  create_table "posts_albums", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "album_url"
    t.integer "popularity"
    t.integer "track_number"
    t.datetime "release_date", precision: 6
    t.text "image_data"
    t.integer "counter_likeable", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false
    t.index ["user_id", "deleted", "created_at"], name: "index_posts_albums_on_user_id_and_deleted_and_played_at"
  end

  create_table "posts_tracks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "played_at", precision: 6, null: false
    t.integer "duration_ms"
    t.integer "popularity"
    t.string "track_url"
    t.string "album_name", null: false
    t.string "album_url"
    t.string "artists_name", default: [], array: true
    t.string "artists_url", default: [], array: true
    t.text "image_data"
    t.integer "counter_likeable", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false
    t.string "spotify_image_urls", default: [], array: true
    t.index ["user_id", "deleted", "created_at"], name: "index_posts_tracks_on_user_id_and_deleted_and_created_at"
    t.index ["user_id", "deleted", "played_at"], name: "index_posts_tracks_on_user_id_and_deleted_and_played_at"
  end

  create_table "posts_users", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "counter_likeable", default: 0
    t.bigint "user_id", null: false
    t.boolean "deleted", default: false
    t.index ["user_id", "deleted", "created_at"], name: "index_posts_users_on_user_id_and_deleted_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "account_type"
    t.string "nickname", null: false
    t.datetime "birthdate", precision: 6
    t.string "account_country"
    t.string "account_product"
    t.string "account_images", default: [], array: true
    t.text "avatar_data"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "counter_follower", default: 0
    t.integer "counter_following", default: 0
    t.text "bio"
    t.string "profile_url"
    t.string "country"
    t.string "state"
    t.datetime "last_active_at", precision: 6, default: "2022-01-30 19:29:42"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "feeds", "posts"
  add_foreign_key "feeds", "users"
  add_foreign_key "follow_invitations", "users", column: "follower_id"
  add_foreign_key "follow_invitations", "users", column: "following_id"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "users", column: "destinatary_id"
  add_foreign_key "posts", "users"
  add_foreign_key "posts_albums", "users"
  add_foreign_key "posts_tracks", "users"
  add_foreign_key "posts_users", "users"
end
