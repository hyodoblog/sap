class CreateLaboratoryRates < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratory_rates do |t|
      t.references :admin,      foreign_key: true
      t.references :laboratory, foreign_key: true
      t.integer    :rate, null: false, default: 0

      t.timestamps
    end
  end
end
