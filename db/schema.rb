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

ActiveRecord::Schema.define(version: 2021_02_16_063424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "attached_files", force: :cascade do |t|
    t.string "attachment_type", null: false
    t.bigint "attachment_id", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "processing_status"
    t.index ["attachment_type", "attachment_id"], name: "index_attached_files_on_attachment"
    t.index ["subject_type", "subject_id"], name: "index_attached_files_on_subject"
  end

  create_table "audio_files", force: :cascade do |t|
    t.text "title", null: false
    t.text "description"
    t.text "artist"
    t.text "album"
    t.text "file_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "metadata"
  end

  create_table "cache_reactions", force: :cascade do |t|
    t.string "subject_id", null: false
    t.string "reaction_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_cache_reactions_on_subject_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "payload"
    t.bigint "peer_info_id"
    t.bigint "parent_comment_id"
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.integer "sub_comments_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like_count", default: 0, null: false
    t.integer "love_count", default: 0, null: false
    t.integer "wow_count", default: 0, null: false
    t.string "uid", null: false
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
    t.index ["peer_info_id"], name: "index_comments_on_peer_info_id"
    t.index ["subject_type", "subject_id"], name: "index_comments_on_subject"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "peer_info_id", null: false
    t.boolean "has_new_messages", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["peer_info_id"], name: "index_conversations_on_peer_info_id"
  end

  create_table "feed_items", force: :cascade do |t|
    t.string "feed_item_type", null: false
    t.text "url", null: false
    t.bigint "peer_info_id", null: false
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["peer_info_id", "uid"], name: "index_feed_items_on_peer_info_id_and_uid", unique: true
    t.index ["url"], name: "index_feed_items_on_url", unique: true
  end

  create_table "gallery_elements", force: :cascade do |t|
    t.bigint "image_album_id", null: false
    t.string "element_type", null: false
    t.bigint "element_id", null: false
    t.boolean "most_recent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "processing_status"
    t.index ["element_type", "element_id"], name: "index_gallery_elements_on_element"
    t.index ["image_album_id"], name: "index_gallery_elements_on_image_album_id"
  end

  create_table "image_albums", force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.text "location_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "privacy", default: "public_access", null: false
    t.integer "gallery_elements_count", default: 0, null: false
  end

  create_table "image_files", force: :cascade do |t|
    t.string "image_data"
    t.string "dominant_color"
    t.text "location_name"
    t.text "description"
    t.boolean "private", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "metadata"
    t.string "real_file_name"
    t.datetime "real_created_at"
    t.string "md5_checksum"
  end

  create_table "messages", force: :cascade do |t|
    t.text "payload"
    t.string "message_type", null: false
    t.boolean "read", default: false, null: false
    t.bigint "conversation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
  end

  create_table "peer_infos", force: :cascade do |t|
    t.text "username", null: false
    t.string "ip", null: false
    t.text "public_key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "friend_ship_status"
    t.text "name"
    t.text "avatars"
    t.text "about"
    t.string "country_code"
    t.text "city_name"
    t.index ["city_name"], name: "index_peer_infos_on_city_name"
    t.index ["country_code"], name: "index_peer_infos_on_country_code"
    t.index ["name"], name: "index_peer_infos_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["public_key"], name: "index_peer_infos_on_public_key", unique: true
    t.index ["username", "ip"], name: "index_peer_infos_on_username_and_ip"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.string "mood"
    t.text "location_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like_count", default: 0, null: false
    t.integer "love_count", default: 0, null: false
    t.integer "wow_count", default: 0, null: false
    t.string "uid", null: false
    t.string "privacy", default: "public_access", null: false
  end

  create_table "previous_searches", force: :cascade do |t|
    t.bigint "peer_info_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_previous_searches_on_created_at"
    t.index ["peer_info_id"], name: "index_previous_searches_on_peer_info_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "name", null: false
    t.string "username", null: false
    t.string "gender", null: false
    t.text "recover_key", null: false
    t.boolean "recover_key_saved", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "about"
    t.string "country_code"
    t.text "city_name"
  end

  create_table "reactions", force: :cascade do |t|
    t.bigint "peer_info_id"
    t.string "reaction_type", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["peer_info_id", "subject_id"], name: "index_reactions_on_peer_info_id_and_subject_id", unique: true
    t.index ["subject_type", "subject_id"], name: "index_reactions_on_subject"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name", null: false
    t.string "role", null: false
    t.string "ip", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stories", force: :cascade do |t|
    t.text "location_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "like_count", default: 0, null: false
    t.integer "love_count", default: 0, null: false
    t.integer "wow_count", default: 0, null: false
    t.string "uid", null: false
    t.string "privacy", default: "public_access", null: false
  end

  create_table "unblock_requests", force: :cascade do |t|
    t.bigint "peer_info_id", null: false
    t.bigint "peer_info_requester_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["peer_info_id"], name: "index_unblock_requests_on_peer_info_id"
    t.index ["peer_info_requester_id"], name: "index_unblock_requests_on_peer_info_requester_id"
  end

  create_table "video_files", force: :cascade do |t|
    t.string "cover_image_data"
    t.string "dominant_color"
    t.integer "duration_seconds"
    t.text "location_name"
    t.text "video_data"
    t.boolean "private"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "metadata"
    t.string "real_file_name"
    t.datetime "real_created_at"
    t.string "md5_checksum"
  end

  add_foreign_key "comments", "comments", column: "parent_comment_id"
  add_foreign_key "comments", "peer_infos"
  add_foreign_key "conversations", "peer_infos"
  add_foreign_key "feed_items", "peer_infos"
  add_foreign_key "gallery_elements", "image_albums"
  add_foreign_key "messages", "conversations"
  add_foreign_key "previous_searches", "peer_infos"
  add_foreign_key "reactions", "peer_infos"
  add_foreign_key "unblock_requests", "peer_infos"
  add_foreign_key "unblock_requests", "peer_infos", column: "peer_info_requester_id"
end
