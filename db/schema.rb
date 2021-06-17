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

ActiveRecord::Schema.define(version: 2021_06_11_230815) do

  create_table "complete_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "wish_id"
    t.string "review_title"
    t.text "review"
    t.integer "satisfy"
    t.string "complete_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "user_id"
    t.string "tag_name"
    t.string "tag_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "user_image_id"
    t.string "introduction"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wish_tag_relationships", force: :cascade do |t|
    t.integer "wish_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_wish_tag_relationships_on_tag_id"
    t.index ["wish_id"], name: "index_wish_tag_relationships_on_wish_id"
  end

  create_table "wishes", force: :cascade do |t|
    t.integer "user_id"
    t.string "wish_title"
    t.text "memo"
    t.string "wish_image_id"
    t.datetime "span"
    t.integer "difficutly"
    t.boolean "isCompleted", default: false, null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
