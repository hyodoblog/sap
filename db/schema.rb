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

ActiveRecord::Schema.define(version: 2020_02_20_095941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "sap_key"
    t.string "university_name"
    t.string "faculty_name"
    t.string "department_name"
    t.string "contact_email"
    t.integer "max_choice_student"
    t.integer "max_choice_laboratory"
    t.integer "max_confirmed_student"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "view_end_datetime"
    t.boolean "init_setup_flag", default: false
    t.boolean "release_flag", default: false
    t.boolean "start_flag", default: false
    t.boolean "end_flag", default: false
    t.boolean "login_info_email_flag", default: false
    t.boolean "confirmation_notice_flag", default: false
    t.boolean "end_notice_flag", default: false
    t.boolean "view_end_notice_flag", default: false
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "assign_lists", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "laboratory_id"
    t.bigint "student_id"
    t.boolean "confirm", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_assign_lists_on_admin_id"
    t.index ["laboratory_id"], name: "index_assign_lists_on_laboratory_id"
    t.index ["student_id"], name: "index_assign_lists_on_student_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "password_init", default: "", null: false
    t.bigint "admin_id"
    t.string "name", null: false
    t.string "professor_name", null: false
    t.integer "max_num"
    t.integer "latest_rate", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
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
    t.index ["admin_id"], name: "index_laboratories_on_admin_id"
    t.index ["email"], name: "index_laboratories_on_email", unique: true
    t.index ["reset_password_token"], name: "index_laboratories_on_reset_password_token", unique: true
  end

  create_table "laboratory_choices", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "laboratory_id"
    t.bigint "student_id"
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_laboratory_choices_on_admin_id"
    t.index ["laboratory_id"], name: "index_laboratory_choices_on_laboratory_id"
    t.index ["student_id"], name: "index_laboratory_choices_on_student_id"
  end

  create_table "laboratory_rates", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "laboratory_id"
    t.integer "rate", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_laboratory_rates_on_admin_id"
    t.index ["laboratory_id"], name: "index_laboratory_rates_on_laboratory_id"
  end

  create_table "notices", force: :cascade do |t|
    t.bigint "admin_id"
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_notices_on_admin_id"
  end

  create_table "student_choices", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "student_id"
    t.bigint "laboratory_id"
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_student_choices_on_admin_id"
    t.index ["laboratory_id"], name: "index_student_choices_on_laboratory_id"
    t.index ["student_id"], name: "index_student_choices_on_student_id"
  end

  create_table "student_rates", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "student_id"
    t.integer "rate", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_student_rates_on_admin_id"
    t.index ["student_id"], name: "index_student_rates_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "password_init", default: "", null: false
    t.bigint "admin_id"
    t.string "name", null: false
    t.string "student_num", null: false
    t.integer "latest_rate", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
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
    t.index ["admin_id"], name: "index_students_on_admin_id"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  add_foreign_key "assign_lists", "admins"
  add_foreign_key "assign_lists", "laboratories"
  add_foreign_key "assign_lists", "students"
  add_foreign_key "laboratories", "admins"
  add_foreign_key "laboratory_choices", "admins"
  add_foreign_key "laboratory_choices", "laboratories"
  add_foreign_key "laboratory_choices", "students"
  add_foreign_key "laboratory_rates", "admins"
  add_foreign_key "laboratory_rates", "laboratories"
  add_foreign_key "notices", "admins"
  add_foreign_key "student_choices", "admins"
  add_foreign_key "student_choices", "laboratories"
  add_foreign_key "student_choices", "students"
  add_foreign_key "student_rates", "admins"
  add_foreign_key "student_rates", "students"
  add_foreign_key "students", "admins"
end
