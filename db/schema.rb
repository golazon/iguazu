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

ActiveRecord::Schema.define(version: 2020_02_18_195650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed", force: :cascade do |t|
    t.string "type"
    t.string "type_id"
    t.jsonb "content"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type", "type_id"], name: "index_feed_on_type_and_type_id", unique: true
  end

  create_table "http_logs", force: :cascade do |t|
    t.string "url", null: false
    t.datetime "last_modified"
    t.datetime "expires"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "etag"
    t.index ["url"], name: "index_http_logs_on_url", unique: true
  end

end
