# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_15_134608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string "follower_type"
    t.integer "follower_id"
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "likes", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "movie_tags", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_tags_on_movie_id"
    t.index ["tag_id"], name: "index_movie_tags_on_tag_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.date "production"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sub_title"
    t.string "supervision"
    t.integer "country_id", null: false
    t.integer "user_id"
    t.integer "likers_count", default: 0
    t.integer "screen_time"
    t.string "quote_url"
    t.string "synopsis"
    t.bigint "parent_id"
    t.boolean "recommend", default: false, null: false
    t.index ["country_id"], name: "index_movies_on_country_id"
    t.index ["parent_id"], name: "index_movies_on_parent_id"
    t.index ["title", "sub_title"], name: "index_movies_on_title_and_sub_title", unique: true
    t.index ["user_id"], name: "index_movies_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "access"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "theater_id"
    t.integer "stage_id"
    t.integer "movie_id"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like_id"
    t.integer "review_id"
    t.integer "likers_count", default: 0
    t.index ["like_id"], name: "index_posts_on_like_id"
    t.index ["movie_id"], name: "index_posts_on_movie_id"
    t.index ["review_id"], name: "index_posts_on_review_id"
    t.index ["stage_id"], name: "index_posts_on_stage_id"
    t.index ["theater_id"], name: "index_posts_on_theater_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "viewing"
    t.integer "theater_id"
    t.integer "movie_id"
    t.integer "stage_id"
    t.integer "post_id"
    t.integer "likers_count", default: 0
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["post_id"], name: "index_reviews_on_post_id"
    t.index ["stage_id"], name: "index_reviews_on_stage_id"
    t.index ["theater_id"], name: "index_reviews_on_theater_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "soiree_stages", force: :cascade do |t|
    t.bigint "stage_id"
    t.bigint "soiree_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soiree_id"], name: "index_soiree_stages_on_soiree_id"
    t.index ["stage_id"], name: "index_soiree_stages_on_stage_id"
  end

  create_table "soirees", force: :cascade do |t|
    t.date "performance_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stage_tags", force: :cascade do |t|
    t.bigint "stage_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stage_id"], name: "index_stage_tags_on_stage_id"
    t.index ["tag_id"], name: "index_stage_tags_on_tag_id"
  end

  create_table "stages", force: :cascade do |t|
    t.string "company"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "theater_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "place_id"
    t.integer "user_id"
    t.integer "likers_count", default: 0
    t.string "director"
    t.string "quote_url"
    t.text "synopsis"
    t.time "matinee"
    t.time "soiree"
    t.index ["place_id"], name: "index_stages_on_place_id"
    t.index ["theater_id", "start_date"], name: "index_stages_on_theater_id_and_start_date", unique: true
    t.index ["theater_id"], name: "index_stages_on_theater_id"
    t.index ["user_id"], name: "index_stages_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "theaters", force: :cascade do |t|
    t.string "title", null: false
    t.string "writer", null: false
    t.integer "man"
    t.integer "female"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "country_id", null: false
    t.integer "user_id"
    t.integer "likers_count", default: 0
    t.index ["country_id"], name: "index_theaters_on_country_id"
    t.index ["title", "writer"], name: "index_theaters_on_title_and_writer", unique: true
    t.index ["user_id"], name: "index_theaters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "profile"
    t.date "birthday", null: false
    t.integer "sex", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted_flg", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "movie_tags", "movies"
  add_foreign_key "movie_tags", "tags"
  add_foreign_key "movies", "countries"
  add_foreign_key "movies", "users"
  add_foreign_key "posts", "likes"
  add_foreign_key "posts", "movies"
  add_foreign_key "posts", "reviews"
  add_foreign_key "posts", "stages"
  add_foreign_key "posts", "theaters"
  add_foreign_key "posts", "users"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "posts"
  add_foreign_key "reviews", "stages"
  add_foreign_key "reviews", "theaters"
  add_foreign_key "reviews", "users"
  add_foreign_key "soiree_stages", "soirees"
  add_foreign_key "soiree_stages", "stages"
  add_foreign_key "stage_tags", "stages"
  add_foreign_key "stage_tags", "tags"
  add_foreign_key "stages", "places"
  add_foreign_key "stages", "theaters"
  add_foreign_key "stages", "users"
  add_foreign_key "theaters", "countries"
  add_foreign_key "theaters", "users"
end
