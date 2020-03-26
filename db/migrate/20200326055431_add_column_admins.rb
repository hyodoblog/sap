class AddColumnAdmins < ActiveRecord::Migration[5.2]
  def up
    add_column :admins, :point, :integer
  end

  def down
    remove_column :titles, :point, :integer
  end
end
