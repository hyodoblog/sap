class CreateStudentChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :student_choices do |t|
      t.references :student,    foreign_key: true
      t.references :laboratory, foreign_key: true
      t.integer    :rank, null: false

      t.timestamps
    end
  end
end
