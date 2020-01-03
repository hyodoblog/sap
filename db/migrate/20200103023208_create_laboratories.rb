class CreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      t.references :user, foreign_key: true
      t.string     :loginid,         null: false
      t.string     :password,        null: false
      t.string     :laboratory_name, null: false
      t.integer    :max_num

      t.timestamps
    end
  end
end
