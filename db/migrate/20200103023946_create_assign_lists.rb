class CreateAssignLists < ActiveRecord::Migration[5.2]
  def change
    create_table :assign_lists do |t|
      t.references :laboratory, foreign_key: true
      t.references :student,   foreign_key: true
      t.boolean    :confirm,   default: false

      t.timestamps
    end
  end
end
