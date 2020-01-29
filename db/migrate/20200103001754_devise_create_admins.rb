# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Info
      t.integer   :role, null: false, default: ADMIN_ROLE
      t.string    :sap_key
      t.string    :university_name
      t.string    :faculty_name
      t.string    :department_name
      t.string    :contact_email
      t.integer   :max_choice_student
      t.integer   :max_choice_laboratory
      t.integer   :max_confirmed_student
      t.datetime  :start_datetime
      t.datetime  :end_datetime
      t.datetime  :view_end_datetime
      t.boolean   :init_setup_flag,          default: false
      t.boolean   :release_flag,             default: false
      t.boolean   :start_flag,               default: false
      t.boolean   :end_flag,                 default: false
      t.boolean   :login_info_email_flag,    default: false
      t.boolean   :confirmation_notice_flag, default: false
      t.boolean   :end_notice_flag,          default: false
      t.boolean   :view_end_notice_flag,     default: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :admins, :email,                unique: true
    add_index :admins, :reset_password_token, unique: true
    add_index :admins, :confirmation_token,   unique: true
    # add_index :admins, :unlock_token,         unique: true
  end
end
