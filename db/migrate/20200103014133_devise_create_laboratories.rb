# frozen_string_literal: true

class DeviseCreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Info
      t.references :admin,          foreign_key: true
      t.integer    :role,           null: false, default: LABORATORY_ROLE
      t.string     :name,           null: false
      t.string     :professor_name, null: false
      t.integer    :max_num
      t.integer    :rate

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Invitable
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer    :invitations_count, default: 0
      t.index      :invitations_count
      t.index      :invitation_token, unique: true # for invitable
      t.index      :invited_by_id

      t.timestamps null: false
    end

    add_index :laboratories, :email,                unique: true
    add_index :laboratories, :reset_password_token, unique: true
  end
end
