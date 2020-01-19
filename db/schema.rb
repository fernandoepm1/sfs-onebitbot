ActiveRecord::Schema.define(version: 2020_01_15_225944) do
  enable_extension "plpgsql"

  create_table "faq_hashtags", force: :cascade do |t|
    t.integer "faq_id"
    t.integer "hashtag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
