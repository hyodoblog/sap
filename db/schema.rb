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

ActiveRecord::Schema.define(version: 2020_01_03_191925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assign_lists", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "laboratory_id"
    t.bigint "student_id"
    t.boolean "confirm", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_assign_lists_on_laboratory_id"
    t.index ["student_id"], name: "index_assign_lists_on_student_id"
    t.index ["user_id"], name: "index_assign_lists_on_user_id"
  end

  create_table "configs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "sap_key", null: false
    t.string "university_name", null: false
    t.string "faculty_name", null: false
    t.string "department_name", null: false
    t.string "contact_email", null: false
    t.integer "max_choice_student", null: false
    t.integer "max_choice_laboratory", null: false
    t.integer "max_confirm_student"
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime", null: false
    t.datetime "view_end_datetime", null: false
    t.boolean "release_flag", default: false
    t.boolean "finish_flag", default: false
    t.boolean "init_setup_flag", default: false
    t.boolean "login_info_email_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_configs_on_user_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.bigint "user_id"
    t.string "loginid", null: false
    t.string "password_digest", null: false
    t.string "password_back", null: false
    t.string "name", null: false
    t.string "laboratory_name", null: false
    t.integer "max_num"
    t.integer "rate"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loginid", "email"], name: "index_laboratories_on_loginid_and_email", unique: true
    t.index ["user_id"], name: "index_laboratories_on_user_id"
  end

  create_table "laboratory_choices", force: :cascade do |t|
    t.bigint "laboratory_id"
    t.bigint "student_id"
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_laboratory_choices_on_laboratory_id"
    t.index ["student_id"], name: "index_laboratory_choices_on_student_id"
  end

  create_table "student_choices", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "laboratory_id"
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_student_choices_on_laboratory_id"
    t.index ["student_id"], name: "index_student_choices_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id"
    t.string "loginid", null: false
    t.string "password_digest", null: false
    t.string "password_back", null: false
    t.string "name", null: false
    t.string "student_num", null: false
    t.string "rate"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loginid", "email"], name: "index_students_on_loginid_and_email", unique: true
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assign_lists", "laboratories"
  add_foreign_key "assign_lists", "students"
  add_foreign_key "assign_lists", "users"
  add_foreign_key "configs", "users"
  add_foreign_key "laboratories", "users"
  add_foreign_key "laboratory_choices", "laboratories"
  add_foreign_key "laboratory_choices", "students"
  add_foreign_key "student_choices", "laboratories"
  add_foreign_key "student_choices", "students"
  add_foreign_key "students", "users"
end
