class OcrDatafile < ActiveRecord::Base

	require 'CSV'

	require 'pp'

	def self.import(file)

		@ocr_messages = []

		CSV.foreach(file.path, headers: true, col_sep: ';', converters: :numeric) do |row|

			# Any Na;Libby Orbital;Fish;283;299;;;15260;Med;2015-01-31T00:09:38+00:00;
			# row hash:
			# {"System;Station;Commodity;Sell;Buy;Demand;;Supply;;Date;"=>
			#   "Any Na;Libby Orbital;Fish;283;299;;;15260;Med;2015-01-31T00:09:38+00:00;"}

			unless row['Date'].nil?
				system_name    = row['System']
				station_name   = row['Station']
				commodity_name = row['Commodity']
				sell_price     = row['Sell'].to_i
				buy_price      = row['Buy'].to_i
				demand_amnt    = row['Demand'].to_i
				demand_level   = row[6]
				supply_amnt    = row['Supply'].to_i
				supply_level   = row[8]
				date_recorded  = row['Date']

				# TODO remove these conversions when redo station_commodities fields
				case demand_level
				when 'Low'
					demand_level = 'L'
				when 'Med'
					demand_level = 'M'
				when 'High'
					demand_level = 'H'
				end

				case supply_level
				when 'Low'
					supply_level = 'L'
				when 'Med'
					supply_level = 'M'
				when 'High'
					supply_level = 'H'
				end

				puts "System       : #{system_name}"
				puts "Station      : #{station_name}"
				puts "Commodity    : #{commodity_name}"
				puts "Sell         : #{sell_price}"
				puts "Buy          : #{buy_price}"
				puts "Demand Amnt  : #{demand_amnt}"
				puts "Demand_Level : #{demand_level}"
				puts "Supply Amnt  : #{supply_amnt}"
				puts "Supply Level : #{supply_level}"
				puts "Date         : #{date_recorded}"

				# TODO this should probably check name variations, be case insensitive etc
				system = System.find_by_name(system_name)
				unless system
					# create the system
					system_params = {
						'name'          => system_name,
						'allegiance_id' => Allegiance.find_by_name('Unknown').id,
						'government_id' => Government.find_by_name('Unknown').id
					}
					system = System.new(system_params)
					system.save!
					# @ocr_messages.push("No system found for #{system_name}")
					# next
				end

				station = Station.find_by_name(station_name)
				unless station
					# create the station
					station_params = {
						'name'                => station_name,
						'station_type_id'     => StationType.find_by_name('Unknown').id,
						'system_id'           => system.id,
						'allegiance_id'       => Allegiance.find_by_name('Unknown').id,
						'government_id'       => Government.find_by_name('Unknown').id,
						'population_level_id' => PopulationLevel.find_by_name('Unknown').id,
						'has_commodities'     => true,
						'has_refuel'          => false,
						'has_repair'          => false,
						'has_re_arm'          => false,
						'has_outfitting'      => false,
						'has_shipyard'        => false,
						'has_blackmarket'     => false,
						'nav_ls'              => -1,
						'is_economy_agricultural' => false,
						'is_economy_extraction'   => false,
						'is_economy_hi_tech'      => false,
						'is_economy_industrial'   => false,
						'is_economy_military'     => false,
						'is_economy_none'         => false,
						'is_economy_refinery'     => false,
						'is_economy_service'      => false,
						'is_economy_terraforming' => false,
						'is_economy_tourism'      => false
					}
					station = Station.new(station_params)
					station.save!
					# @ocr_messages.push("No station found for #{station_name}")
					# next
				end

				commodity = Commodity.find_by_name(commodity_name)
				unless commodity
					@ocr_messages.push("No commodity found for #{commodity_name}")
					next
				end

				# TODO modify the station_commodities fields when migrate new fields to table
				station_commodity = StationCommodity.where("station_id = ? AND commodity_id = ?", station.id, commodity.id).first
				if station_commodity
					# update the existing station commodity
					if demand_amnt > 0
						station_commodity.demanded_or_supplied   = 'D'
						station_commodity.demand_or_supply_level = demand_level
						station_commodity.buy_or_sell_price      = sell_price
					else
						if supply_amnt > 0
							station_commodity.demanded_or_supplied   = 'S'
							station_commodity.demand_or_supply_level = supply_level
							station_commodity.buy_or_sell_price      = buy_price
						else
							@ocr_messages.push("ERROR: Updated Station commodity niether demanded or supplied, skipped!")
							next
						end
					end
					station_commodity.save!
					@ocr_messages.push("Station commodity UPDATED for station #{station_name} and commodity #{commodity_name}")
				else
					# create a new station commodity
					station_commodity_params = {
						'station_id' => station.id,
						'commodity_id' => commodity.id
					}
					if demand_amnt > 0
						station_commodity_params['demanded_or_supplied']   = 'D'
						station_commodity_params['demand_or_supply_level'] = demand_level
						station_commodity_params['buy_or_sell_price']      = sell_price
					else
						if supply_amnt > 0
							station_commodity_params['demanded_or_supplied']   = 'S'
							station_commodity_params['demand_or_supply_level'] = supply_level
							station_commodity_params['buy_or_sell_price']      = buy_price
						else
							@ocr_messages.push("ERROR: New Station commodity niether demanded or supplied, skipped!")
							next
						end
					end
					station_commodity = StationCommodity.new(station_commodity_params)
					station_commodity.save!
					@ocr_messages.push("Station commodity CREATED for station #{station_name} and commodity #{commodity_name}")
				end
			else
				puts "ERROR with csv row, no date so row incomplete"
			end
		end # end CSV.foreach
		return @ocr_messages
	end # end self.import(file)
end
