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

ActiveRecord::Schema.define(version: 2020_06_17_102920) do

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "url"
    t.text "body"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "tweeted_at"
    t.index ["title"], name: "index_news_on_title"
  end

  create_table "pages", force: :cascade do |t|
    t.text "url"
    t.text "crawler_config"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.index ["url"], name: "index_pages_on_url", unique: true
  end

  create_table "url_patterns", force: :cascade do |t|
    t.text "url"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.index ["url"], name: "index_url_patterns_on_url", unique: true
  end

  create_table "urls", force: :cascade do |t|
    t.text "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "tweeted_at"
    t.string "title"
    t.index ["url"], name: "index_urls_on_url", unique: true
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_user_agents_on_name", unique: true
  end

end
