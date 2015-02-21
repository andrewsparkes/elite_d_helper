class RemoveStationCommoditiesColumns < ActiveRecord::Migration
  def up
  	remove_column :station_commodities, :demanded_or_supplied
		remove_column :station_commodities, :demand_or_supply_level
    remove_column :station_commodities, :buy_or_sell_price
  end

  def down
  	add_column :station_commodities, :demanded_or_supplied, :string, :null => true
    add_column :station_commodities, :demand_or_supply_level, :string, :null => true
    add_column :station_commodities, :buy_or_sell_price, :integer, :null => true
  end
end