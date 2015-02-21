class ModifyStationCommodities < ActiveRecord::Migration
  def up
  	# add additional columns to station_commodities
  	add_column :station_commodities, :sell, :integer, :null => true
  	add_column :station_commodities, :buy, :integer, :null => true
  	add_column :station_commodities, :demand, :integer, :null => true
  	add_column :station_commodities, :demand_level, :string, :null => true
  	add_column :station_commodities, :supply, :integer, :null => true
  	add_column :station_commodities, :supply_level, :string, :null => true
  end

  # SQL to update new fields
  #  UPDATE station_commodities
	# --SET sell = buy_or_sell_price, demand = 0, demand_level = 'Low' WHERE demanded_or_supplied = 'D' and demand_or_supply_level = 'L'
	# --SET sell = buy_or_sell_price, demand = 0, demand_level = 'Med' WHERE demanded_or_supplied = 'D' and demand_or_supply_level = 'M'
	# --SET sell = buy_or_sell_price, demand = 0, demand_level = 'High' WHERE demanded_or_supplied = 'D' and demand_or_supply_level = 'H'
	# --SET buy = buy_or_sell_price, supply = 0, supply_level = 'Low' WHERE demanded_or_supplied = 'S' and demand_or_supply_level = 'L'
	# --SET buy = buy_or_sell_price, supply = 0, supply_level = 'Med' WHERE demanded_or_supplied = 'S' and demand_or_supply_level = 'M'
	# SET buy = buy_or_sell_price, supply = 0, supply_level = 'High' WHERE demanded_or_supplied = 'S' and demand_or_supply_level = 'H'
	# ;

  def down
  	# remove columns from station_commodities
  	remove_column :station_commodities, :supply_level
  	remove_column :station_commodities, :supply
  	remove_column :station_commodities, :demand_level
  	remove_column :station_commodities, :demand
  	remove_column :station_commodities, :buy
  	remove_column :station_commodities, :sell
  end
end