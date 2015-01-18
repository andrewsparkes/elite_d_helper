class RemoveStationEconomies < ActiveRecord::Migration
  def up
  	# drop station_economies table
  	drop_table :station_economies

  	# drop economies table
	drop_table :economies

  	# add economies boolean flags to station table
  	add_column :stations, :is_economy_agricultural, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_extraction, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_hi_tech, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_industrial, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_military, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_none, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_refinery, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_service, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_terraforming, :boolean, :null => false, :default => false
  	add_column :stations, :is_economy_tourism, :boolean, :null => false, :default => false
  end

  def down
  	remove_column :stations, :is_economy_tourism
  	remove_column :stations, :is_economy_terraforming
  	remove_column :stations, :is_economy_service
  	remove_column :stations, :is_economy_refinery
  	remove_column :stations, :is_economy_none
  	remove_column :stations, :is_economy_military
  	remove_column :stations, :is_economy_industrial
  	remove_column :stations, :is_economy_hi_tech
  	remove_column :stations, :is_economy_extraction
  	remove_column :stations, :is_economy_agricultural

  	create_table :economies do |t|
      t.string :name

      t.timestamps
    end

    create_table :station_economies do |t|
      t.integer :station_id
      t.integer :economy_id

      t.timestamps
    end
  end
end