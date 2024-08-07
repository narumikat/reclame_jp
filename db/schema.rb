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

ActiveRecord::Schema[7.1].define(version: 2024_08_02_020915) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.string "company_register_number"
    t.string "company_address"
    t.string "company_city"
    t.string "company_state"
    t.string "company_zip_code"
    t.string "company_country"
    t.string "company_phone_number"
    t.string "company_website"
    t.jsonb "company_social_media", default: []
    t.text "company_description"
    t.string "company_category", array: true
    t.string "company_contact_name"
    t.string "company_contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies_users", force: :cascade do |t|
    t.string "role"
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_users_on_company_id"
    t.index ["user_id"], name: "index_companies_users_on_user_id"
  end

  create_table "complaints", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id"
    t.jsonb "company_social_media", default: []
    t.string "title"
    t.integer "review"
    t.text "comment"
    t.integer "status", default: 0
    t.string "complaint_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_complaints_on_company_id"
    t.index ["user_id"], name: "index_complaints_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.bigint "complaint_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_responses_on_company_id"
    t.index ["complaint_id"], name: "index_responses_on_complaint_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false
    t.boolean "is_company", default: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies_users", "companies"
  add_foreign_key "companies_users", "users"
  add_foreign_key "complaints", "companies"
  add_foreign_key "complaints", "users"
  add_foreign_key "responses", "companies"
  add_foreign_key "responses", "complaints"
  add_foreign_key "responses", "users"
end
