class CreateConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :configs do |t|
      t.string   :sap_key,               null: false
      t.string   :university_name,       null: false
      t.string   :faculty_name,          null: false
      t.string   :department_name,       null: false
      t.string   :contact_email,         null: false
      t.integer  :max_choice_student,    null: false
      t.integer  :max_choice_laboratory, null: false
      t.datetime :start_datetime,        null: false
      t.datetime :end_datetime,          null: false
      t.datetime :view_end_datetime,     null: false
      t.boolean  :release_flag,    default: false
      t.boolean  :init_setup_flag, default: false

      t.timestamps
    end
  end
end
