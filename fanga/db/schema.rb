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

ActiveRecord::Schema.define(version: 2017_07_13_130552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_to_categories", force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
    t.index ["article_id", "category_id"], name: "index_article_to_categories_on_article_id", unique: true
  end

  create_table "article_translations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "article_id"
    t.integer "lang_id"
    t.index ["article_id", "lang_id"], name: "index_article_translations_on_article_id_lang", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.boolean "visible"
    t.float "price"
    t.index ["visible"], name: "index_article_on_visible"
  end

  create_table "categories", force: :cascade do |t|
    t.boolean "visible"
    t.index ["visible"], name: "index_category_on_visible"
  end

  create_table "category_translations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "category_id"
    t.integer "lang_id"
    t.index ["category_id", "lang_id"], name: "index_category_translations_on_category_id", unique: true
  end

  create_table "langs", force: :cascade do |t|
    t.text "iso", null: false
    t.text "language"
    t.index ["iso"], name: "index_lang_on_iso", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.boolean "activate_account"
    t.string "surname"
    t.string "nickname"
    t.date "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "article_to_categories", "articles"
  add_foreign_key "article_to_categories", "categories"
  add_foreign_key "article_translations", "articles"
  add_foreign_key "article_translations", "langs"
  add_foreign_key "category_translations", "categories"
  add_foreign_key "category_translations", "langs"
end
