class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :user, foreign_key: true
      t.string     :loginid,           null: false
      t.string     :password_digest, null: false
      t.string     :name,            null: false
      t.string     :student_num,     null: false
      t.string     :email

      t.timestamps
    end

    add_index :students, [:loginid, :email], unique: true
  end
end
