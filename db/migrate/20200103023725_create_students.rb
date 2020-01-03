class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :user, foreign_key: true
      t.string     :loginid,     null: false
      t.string     :password,    null: false
      t.string     :name,        null: false
      t.string     :student_num, null: false

      t.timestamps
    end
  end
end
