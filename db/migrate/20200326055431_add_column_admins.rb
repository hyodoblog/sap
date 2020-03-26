class AddColumnAdmins < ActiveRecord::Migration[5.2]
  def up
    add_column :admins, :point, :integer
    add_column :admins, :first_point, :integer
    add_column :admins, :second_point, :integer
    add_column :admins, :third_point, :integer
    add_column :admins, :other_point, :integer
  end

  def down
    remove_column :admins, :point, :integer
    remove_column :admins, :first_point, :integer
    remove_column :admins, :second_point, :integer
    remove_column :admins, :third_point, :integer
    remove_column :admins, :other_point, :integer
  end
end
