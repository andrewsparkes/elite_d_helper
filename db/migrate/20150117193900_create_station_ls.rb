class CreateStationLs < ActiveRecord::Migration
  def up
  	# add field stations.nav_ls (int, null)
    add_column :stations, :nav_ls, :integer, :null => true
  end

  def down
  	remove_column :stations, :nav_ls
  end
end