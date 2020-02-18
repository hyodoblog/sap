# frozen_string_literal: true

class DeviseCreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :password_init,      null: false, default: ""

      ## Info
      t.references :admin,          foreign_key: true
      t.string     :name,           null: false
      t.string     :professor_name, null: false
      t.integer    :max_num
      t.integer    :latest_rate, null: false, default: 0

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

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :laboratories, [:email],              unique: true
    add_index :laboratories, :reset_password_token, unique: true
  end
end
