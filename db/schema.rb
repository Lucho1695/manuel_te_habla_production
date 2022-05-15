# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_15_210117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "name"
    t.string "answer_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blobs", force: :cascade do |t|
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "category_image"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "users"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_categories_on_creator_id"
  end

  create_table "group_user_people", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_files", force: :cascade do |t|
    t.string "filename"
    t.string "content_type"
    t.integer "file_size"
    t.boolean "principal_file", default: false
    t.integer "category_id", default: -1, null: false
    t.integer "blob_id", default: -1, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blob_id"], name: "index_image_files_on_blob_id"
    t.index ["category_id"], name: "index_image_files_on_category_id"
    t.index ["deleted"], name: "index_image_files_on_deleted"
    t.index ["filename"], name: "index_image_files_on_filename"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.boolean "status", default: true
    t.integer "roles", default: 2
    t.json "comments"
    t.bigint "user_id"
    t.string "email"
    t.string "password"
    t.integer "user_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["name"], name: "index_people_on_name"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_questionnaires_on_creator_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "questionnaire_id", null: false
    t.string "name"
    t.integer "question_type"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "answer_id"
    t.bigint "user_id"
    t.float "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "audio_response"
    t.integer "response_type"
    t.bigint "questionnaire_id"
    t.index ["answer_id"], name: "index_responses_on_answer_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["questionnaire_id"], name: "index_responses_on_questionnaire_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "say_ideas", force: :cascade do |t|
    t.string "title"
    t.integer "say_idea_type"
    t.boolean "public"
    t.bigint "category_id"
    t.bigint "article_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "say_idea_image"
    t.bigint "say_ideas_id"
    t.bigint "creator_id"
    t.index ["article_id"], name: "index_say_ideas_on_article_id"
    t.index ["category_id"], name: "index_say_ideas_on_category_id"
    t.index ["creator_id"], name: "index_say_ideas_on_creator_id"
    t.index ["say_ideas_id"], name: "index_say_ideas_on_say_ideas_id"
    t.index ["user_id"], name: "index_say_ideas_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "title"
    t.string "subcategories_image"
    t.bigint "article_id"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_subcategories_on_article_id"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "upload_files", force: :cascade do |t|
    t.string "filename"
    t.string "content_type"
    t.string "sub_title"
    t.integer "file_size"
    t.boolean "principal_file", default: false
    t.bigint "category_id"
    t.bigint "blob_id"
    t.bigint "person_id"
    t.bigint "video_id"
    t.bigint "say_idea_id"
    t.bigint "user_id"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blob_id"], name: "index_upload_files_on_blob_id"
    t.index ["category_id"], name: "index_upload_files_on_category_id"
    t.index ["deleted"], name: "index_upload_files_on_deleted"
    t.index ["filename"], name: "index_upload_files_on_filename"
    t.index ["person_id"], name: "index_upload_files_on_person_id"
    t.index ["say_idea_id"], name: "index_upload_files_on_say_idea_id"
    t.index ["user_id"], name: "index_upload_files_on_user_id"
    t.index ["video_id"], name: "index_upload_files_on_video_id"
  end

  create_table "user_log_withs", force: :cascade do |t|
    t.bigint "user_log_id", null: false
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_log_id"], name: "index_user_log_withs_on_user_log_id"
  end

  create_table "user_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "ip_address"
    t.string "controller"
    t.string "action"
    t.string "note"
    t.string "browser"
    t.boolean "have_more_description", default: false
    t.string "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "user_roles", default: 2
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_videos_on_creator_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "categories", "users", column: "creator_id"
  add_foreign_key "people", "users"
  add_foreign_key "questionnaires", "users", column: "creator_id"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "say_ideas", "articles"
  add_foreign_key "say_ideas", "categories"
  add_foreign_key "say_ideas", "users"
  add_foreign_key "say_ideas", "users", column: "creator_id"
  add_foreign_key "subcategories", "articles"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "upload_files", "blobs"
  add_foreign_key "upload_files", "categories"
  add_foreign_key "upload_files", "people"
  add_foreign_key "upload_files", "say_ideas"
  add_foreign_key "upload_files", "users"
  add_foreign_key "upload_files", "videos"
  add_foreign_key "user_log_withs", "user_logs"
  add_foreign_key "user_logs", "users"
  add_foreign_key "videos", "users", column: "creator_id"
end
