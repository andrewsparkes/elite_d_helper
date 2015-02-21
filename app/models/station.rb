class Station < ActiveRecord::Base

	require 'pp'

	# system has many stations
	belongs_to :system, inverse_of: :stations
	belongs_to :station_type, inverse_of: :stations
	belongs_to :allegiance, inverse_of: :stations
	belongs_to :government, inverse_of: :stations
	belongs_to :population_level, inverse_of: :stations

	# station commodities
	has_many :station_commodities, inverse_of: :station, :dependent => :destroy
  has_many :commodities, through: :station_commodities

	# must be unique on name
	validates :name, presence: true, uniqueness: true

	validates :system, presence: true
	validates :station_type, presence: true
	validates :allegiance, presence: true
	validates :government, presence: true
	validates :population_level, presence: true
	validates :nav_ls, presence: true, numericality: { only_integer: true }

	validates_inclusion_of :has_commodities, :in => [true, false]
	validates_inclusion_of :has_refuel, :in => [true, false]
	validates_inclusion_of :has_repair, :in => [true, false]
	validates_inclusion_of :has_re_arm, :in => [true, false]
	validates_inclusion_of :has_outfitting, :in => [true, false]
	validates_inclusion_of :has_shipyard, :in => [true, false]
	validates_inclusion_of :has_blackmarket, :in => [true, false]

	validates_inclusion_of :is_economy_agricultural, :in => [true, false]
	validates_inclusion_of :is_economy_extraction, :in => [true, false]
	validates_inclusion_of :is_economy_hi_tech, :in => [true, false]
	validates_inclusion_of :is_economy_industrial, :in => [true, false]
	validates_inclusion_of :is_economy_military, :in => [true, false]
	validates_inclusion_of :is_economy_none, :in => [true, false]
	validates_inclusion_of :is_economy_refinery, :in => [true, false]
	validates_inclusion_of :is_economy_service, :in => [true, false]
	validates_inclusion_of :is_economy_terraforming, :in => [true, false]
	validates_inclusion_of :is_economy_tourism, :in => [true, false]

	# trade route constants
	# MIN_COMM_VAL        = 200
	# MIN_PROFIT_PER_LEG  = 300
	# MIN_PROFIT_PER_LOOP = 1200

	SQL_SOURCE_SELLS = <<-ENDSQL
		SELECT commodities.name AS commodity_name,
		station_commodities.commodity_id,
		station_commodities.supply_level,
		station_commodities.buy,
		commodity_types.name AS commodity_type_name,
		commodities.commodity_type_id,
		commodities.galactic_average_price
		FROM station_commodities
		JOIN commodities ON commodities.id = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id = commodities.commodity_type_id
		WHERE station_commodities.station_id = ?
		AND station_commodities.buy > 0
		ORDER BY station_commodities.commodity_id;
	ENDSQL

	# AND station_commodities.supply > 0

	SQL_DEMAND_BUYS = <<-ENDSQL
		SELECT systems.id AS system_id,
		systems.name AS system_name,
		stations.id AS station_id,
		stations.name AS station_name,
		station_commodities.demand_level,
		station_commodities.sell
		FROM station_commodities
		JOIN stations ON stations.id = station_commodities.station_id
		JOIN systems ON systems.id = stations.system_id
		WHERE station_commodities.station_id != ?
		AND station_commodities.sell > 0
		AND station_commodities.commodity_id = ?
		ORDER BY systems.name, stations.name;
	ENDSQL

	SQL_ALL_TRADES = <<-ENDSQL
		SELECT t_sellers.seller_system_name,
		t_sellers.seller_station_name,
		t_sellers.seller_commodity_type_id,
		t_sellers.seller_commodity_type_name,
		t_sellers.seller_commodity_type_order_num,
		t_sellers.seller_commodity_id,
		t_sellers.seller_commodity_name,
		t_sellers.seller_sell_level,
		t_sellers.seller_price,
		t_buyers.buyer_system_name,
		t_buyers.buyer_station_name,
		t_buyers.buyer_demand_level,
		t_buyers.buyer_price,
		t_buyers.buyer_price - t_sellers.seller_price AS profit
		FROM (
		SELECT systems.name AS seller_system_name,
		stations.name AS seller_station_name,
		commodity_types.id AS seller_commodity_type_id,
		commodity_types.name AS seller_commodity_type_name,
		commodity_types.order_num AS seller_commodity_type_order_num,
		commodities.id AS seller_commodity_id,
		commodities.name AS seller_commodity_name,
		station_commodities.supply_level AS seller_sell_level,
		station_commodities.buy AS seller_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.buy > 0
		) AS t_sellers
		JOIN (
		SELECT systems.name AS buyer_system_name,
		stations.name AS buyer_station_name,
		commodity_types.id AS buyer_commodity_type_id,
		commodity_types.name AS buyer_commodity_type_name,
		commodity_types.order_num AS buyer_commodity_type_order_num,
		commodities.id AS buyer_commodity_id,
		commodities.name AS buyer_commodity_name,
		station_commodities.demand_level AS buyer_demand_level,
		station_commodities.sell AS buyer_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.sell > 0
		) AS t_buyers
		ON t_sellers.seller_commodity_id = t_buyers.buyer_commodity_id
		ORDER BY t_sellers.seller_system_name, t_sellers.seller_station_name, profit desc
		;
	ENDSQL


	SQL_SELLERS_FOR_COMMODITY = <<-ENDSQL
		SELECT systems.name AS seller_system_name,
		stations.name AS seller_station_name,
		commodity_types.id AS seller_commodity_type_id,
		commodity_types.name AS seller_commodity_type_name,
		commodity_types.order_num AS seller_commodity_type_order_num,
		commodities.id AS seller_commodity_id,
		commodities.name AS seller_commodity_name,
		station_commodities.supply_level AS seller_sell_level,
		station_commodities.buy AS seller_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.buy > 0
		AND commodities.id = ?
		ORDER BY seller_price asc, seller_system_name, seller_station_name
		;
	ENDSQL


	SQL_STATIONS_SUPPLY = <<-ENDSQL
		SELECT stations.id AS station_id,
		stations.name AS station_name,
		commodities.name AS commodity_name,
		station_commodities.commodity_id,
		station_commodities.supply,
		station_commodities.supply_level,
		station_commodities.buy,
		commodity_types.name AS commodity_type_name,
		commodities.commodity_type_id,
		commodities.galactic_average_price
		FROM stations
		JOIN station_commodities ON station_commodities.station_id = stations.id
		JOIN commodities ON commodities.id = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id = commodities.commodity_type_id
		WHERE station_commodities.buy > ?
		ORDER BY station_name, commodity_name
		;
	ENDSQL

	SQL_STATIONS_DEMAND = <<-ENDSQL
		SELECT stations.id AS station_id,
		stations.name AS station_name,
		commodities.name AS commodity_name,
		station_commodities.commodity_id,
		station_commodities.demand,
		station_commodities.demand_level,
		station_commodities.sell,
		commodity_types.name AS commodity_type_name,
		commodities.commodity_type_id,
		commodities.galactic_average_price
		FROM stations
		JOIN station_commodities ON station_commodities.station_id = stations.id
		JOIN commodities ON commodities.id = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id = commodities.commodity_type_id
		WHERE station_commodities.sell > ?
		ORDER BY station_name, commodity_name
		;
	ENDSQL

	def buyers_for_supply
		station_id = id

		# trades_array = []
		trades_hash = {
			:commodity_types => {}
		}

		seller_st = ActiveRecord::Base.connection.raw_connection.prepare(SQL_SOURCE_SELLS)
		seller_st.execute(station_id).each do |seller_row|

			curr_commodity_type_id      = seller_row['commodity_type_id']
			curr_commodity_type_name    = seller_row['commodity_type_name']
			curr_commodity_id           = seller_row['commodity_id']
			curr_commodity_name         = seller_row['commodity_name']
			curr_supply                 = seller_row['supply']
			curr_supply_level           = seller_row['supply_level']
			curr_buy_price              = seller_row['buy']
			curr_galactic_average_price = seller_row['galactic_average_price']

			unless trades_hash[:commodity_types].has_key?(curr_commodity_type_name)
				trades_hash[:commodity_types][curr_commodity_type_name] = {
					:commodity_type_id  => curr_commodity_type_id,
					:seller_commodities => {}
				}
			end

			unless trades_hash[:commodity_types][curr_commodity_type_name].has_key?(curr_commodity_name)
				trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name] = {
					:commodity_id           => curr_commodity_id,
					:supply                 => curr_supply,
					:supply_level           => curr_supply_level,
					:buy_price              => curr_buy_price,
					:galactic_average_price => curr_galactic_average_price,
					:buyer_systems          => {}
				}
			end

			buyer_st = ActiveRecord::Base.connection.raw_connection.prepare(SQL_DEMAND_BUYS)
			buyer_st.execute(station_id, curr_commodity_id).each do |buyer_row|

				curr_system_id              = buyer_row['system_id']
				curr_system_name            = buyer_row['system_name']
				curr_station_id             = buyer_row['station_id']
				curr_station_name           = buyer_row['station_name']
				curr_demand                 = buyer_row['demand']
				curr_demand_level           = buyer_row['demand_level']
				curr_sell_price             = buyer_row['sell']

				unless trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems].has_key?(curr_system_name)
					trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems][curr_system_name] = {
						:system_id          => curr_system_id,
						:buyer_stations     => {}
					}
				end

				trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems][curr_system_name][:buyer_stations][curr_station_name] = {
					:station_id             => curr_station_id,
					:demand                 => curr_demand,
					:demand_level           => curr_demand_level,
					:sell_price             => curr_sell_price
				}

			end
			buyer_st.close
		end

		seller_st.close

		return trades_hash
	end

	def self.calculate_distance_between_station_names(nameA, nameB)
		unless nameA && nameB
			return nil
		end

		stationA = Station.find_by_name(nameA)
		stationB = Station.find_by_name(nameB)

		distance = self.distance_between_stations(stationA, stationB)
		return distance
	end

	def self.distance_between_stations(stationA, stationB)
		unless stationA && stationB
			return nil
		end

		distance = System.distance_between_systems(stationA.system, stationB.system)
		return distance
	end

	def self.who_sells_commodity(commodity_id)

		display_array = []

		sql_sellers = ActiveRecord::Base.send(:sanitize_sql_array, [SQL_SELLERS_FOR_COMMODITY, commodity_id.to_i])
		results = ActiveRecord::Base.connection.execute(sql_sellers)

		results.each do |row|
			display_array.push(row)
		end

		return display_array

	end

	def self.calculate_all_possible_trade_legs(params)
		# Inputs:
		# (station LS from jump-in)

		avail_cargo_space    = params[:cargo_space].to_i
		max_distance         = params[:max_distance].to_f
		min_comm_val         = params[:min_commodity_value].to_i
		min_profit_per_leg   = params[:min_leg_profit].to_i
		min_profit_per_loop  = params[:min_loop_profit].to_i

		puts "avail_cargo_space   = #{avail_cargo_space}"
		puts "max_distance        = #{max_distance}"
		puts "min_comm_val        = #{min_comm_val}"
		puts "min_profit_per_leg  = #{min_profit_per_leg}"
		puts "min_profit_per_loop = #{min_profit_per_loop}"

		stations = {}

		# add supplier stations and commodities
		stations = find_supplier_station_commodities(stations, min_comm_val)

		# add buyer stations and commodities
		stations = find_buyer_station_commodities(stations, min_comm_val)

		# pp stations

		# calculate all possible trade legs
		seller_trade_legs = calculate_trade_legs(stations, min_profit_per_leg, avail_cargo_space, max_distance)

		# pp seller_trade_legs

		systems_hash = {}

		leg_keys = seller_trade_legs.keys.sort
		leg_keys.each do |from_station_name|
			from_station_hash = seller_trade_legs[from_station_name]
			from_station = Station.find_by_name(from_station_name)
			from_station_system = from_station.system
			from_station_system_name = from_station_system.name

			unless systems_hash.has_key?(from_station_system_name)
				systems_hash[from_station_system_name] = {
					'stations' => {}
				}
			end

			systems_hash[from_station_system_name]['stations'][from_station_name] = from_station_hash
		end

		# pp systems_hash

		return systems_hash
	end

	def self.calculate_all_possible_trade_routes(params)
		# Inputs:
		# (station LS from jump-in)

		avail_cargo_space    = params[:cargo_space].to_i
		max_distance         = params[:max_distance].to_f
		min_comm_val         = params[:min_commodity_value].to_i
		min_profit_per_leg   = params[:min_leg_profit].to_i
		min_profit_per_loop  = params[:min_loop_profit].to_i

		puts "avail_cargo_space   = #{avail_cargo_space}"
		puts "max_distance        = #{max_distance}"
		puts "min_comm_val        = #{min_comm_val}"
		puts "min_profit_per_leg  = #{min_profit_per_leg}"
		puts "min_profit_per_loop = #{min_profit_per_loop}"

		stations = {}

		# add supplier stations and commodities
		stations = find_supplier_station_commodities(stations, min_comm_val)

		# add buyer stations and commodities
		stations = find_buyer_station_commodities(stations, min_comm_val)

		# pp stations

		# calculate all possible trade legs
		seller_trade_legs = calculate_trade_legs(stations, min_profit_per_leg, avail_cargo_space, max_distance)

		# now we have individual trade legs we can look for simple 2-station loops
		two_station_trade_routes = calculate_two_station_trade_routes(min_profit_per_loop, seller_trade_legs, max_distance)

		display_array = []

		route_keys = two_station_trade_routes.keys.sort
		route_keys.each do |from_station_name|
			from_station_hash = two_station_trade_routes[from_station_name]
			from_station_display_hash = {
				from_station_name => from_station_hash
			}
			# need to display in order of profit by to station
			display_array.push(from_station_display_hash)
		end

		return display_array
	end

	private
		def self.find_supplier_station_commodities(stations, min_comm_val)
			# add supplier stations and commodities
			sql_stations_supply = ActiveRecord::Base.send(:sanitize_sql_array, [SQL_STATIONS_SUPPLY, min_comm_val])
			stations_supply_results = ActiveRecord::Base.connection.execute(sql_stations_supply)

			stations_supply_results.each do |supply_row|

				curr_station_name   = supply_row['station_name']
				curr_commodity_name = supply_row['commodity_name']
				curr_supply         = supply_row['supply']
				curr_supply_level   = supply_row['supply_level']
				curr_price          = supply_row['buy']

				unless stations.has_key?(curr_station_name)
					stations[curr_station_name] = {
						'supplies_commodities' => {}
					}
				end

				stations[curr_station_name]['supplies_commodities'][curr_commodity_name] = {
					'price'         => curr_price,
					'supply'        => curr_supply,
					'supply_level'  => curr_supply_level
				}

			end

			return stations
		end

		def self.find_buyer_station_commodities(stations, min_comm_val)

			sql_stations_demand = ActiveRecord::Base.send(:sanitize_sql_array, [SQL_STATIONS_DEMAND, min_comm_val])
			stations_demand_results = ActiveRecord::Base.connection.execute(sql_stations_demand)

			stations_demand_results.each do |demand_row|

				curr_station_name   = demand_row['station_name']
				curr_commodity_name = demand_row['commodity_name']
				curr_demand         = demand_row['demand']
				curr_demand_level   = demand_row['demand_level']
				curr_price          = demand_row['sell']

				unless stations.has_key?(curr_station_name)
					stations[curr_station_name] = {}
				end

				unless stations[curr_station_name].has_key?('demands_commodities')
					stations[curr_station_name]['demands_commodities'] = {}
				end

				stations[curr_station_name]['demands_commodities'][curr_commodity_name] = {
					'price'        => curr_price,
					'demand'       => curr_demand,
					'demand_level' => curr_demand_level
				}

			end

			return stations
		end

		def self.calculate_trade_legs(stations, min_profit_per_leg, avail_cargo_space, max_distance)
			seller_trade_legs = {}

			# get array sorted keys in stations
			stations_keys = stations.keys.sort

			stations_keys.each do |curr_seller_station|

		    unless stations[curr_seller_station].has_key?('supplies_commodities')
		    	puts "skipping station #{curr_seller_station} as does not supply anything"
		    	next
		    end

				# cycle commodities looking for stations with demand
		    curr_sell_commodities_keys = stations[curr_seller_station]['supplies_commodities'].keys.sort
		    curr_sell_commodities_keys.each do |curr_seller_commodity|

		    	seller_commodity_price = stations[curr_seller_station]['supplies_commodities'][curr_seller_commodity]['price']

		    	puts "Station #{curr_seller_station} supplies commodity : #{curr_seller_commodity} at price #{seller_commodity_price}"
		      # find any buyer stations
		    	stations_keys.each do |curr_buyer_station|

		    		puts "Checking if station #{curr_buyer_station} demands #{curr_seller_commodity}"

		        # ignore if no stations[curr_buyer_station]['demands_commodities']
		    		unless stations[curr_buyer_station].has_key?('demands_commodities')
				    	puts "skipping station #{curr_buyer_station} as does not demand anything"
				    	next
				    end

	        	if stations[curr_buyer_station]['demands_commodities'].has_key?(curr_seller_commodity)
	        		puts "Station #{curr_buyer_station} does buy #{curr_seller_commodity}, checking profit"
              # calculate potential profit
              buyer_commodity_price = stations[curr_buyer_station]['demands_commodities'][curr_seller_commodity]['price']
              profit = buyer_commodity_price - seller_commodity_price
              puts "profit = #{profit} cr"
              if profit > min_profit_per_leg

              	# ignore if out of range
		    				distance_ly = self.calculate_distance_between_station_names(curr_seller_station, curr_buyer_station)
		  					if ( distance_ly <= max_distance )

	              	puts "storing trade leg"
	                # store potential trade leg
	                unless seller_trade_legs.has_key?(curr_seller_station)
										seller_trade_legs[curr_seller_station] = {}
									end

									unless seller_trade_legs[curr_seller_station].has_key?(curr_seller_commodity)
										seller_trade_legs[curr_seller_station][curr_seller_commodity] = {
											'seller_price' => seller_commodity_price,
											'buyer_stations' => {}
										}
									end

									seller_trade_legs[curr_seller_station][curr_seller_commodity]['buyer_stations'][curr_buyer_station] = {
										'buyer_price' => buyer_commodity_price,
										'profit' => profit
									}
								end
            	end
          	end
	        end
		    end
			end

			return seller_trade_legs
		end

		def self.calculate_two_station_trade_routes(min_profit_per_loop, seller_trade_legs, max_distance)

			two_station_trade_routes = {}
			puts "in two station trade routes calc"

			out_station_keys = seller_trade_legs.keys.sort
			out_station_keys.each do |curr_out_station|
				puts "out station = #{curr_out_station}"

		    out_station_commodities_keys = seller_trade_legs[curr_out_station].keys.sort
		    out_station_commodities_keys.each do |curr_out_commodity|
		    	puts "out commodity = #{curr_out_commodity}"

		    	back_station_keys = seller_trade_legs[curr_out_station][curr_out_commodity]['buyer_stations'].keys.sort
		    	back_station_keys.each do |curr_back_station|
		    		puts "checking back station = #{curr_back_station}"

		    		next unless seller_trade_legs.has_key?(curr_back_station)

		    		puts "found trade legs for back station = #{curr_back_station}"

		    		back_station_commodities_keys = seller_trade_legs[curr_back_station].keys.sort
		    		back_station_commodities_keys.each do |curr_back_commodity|
		    			puts "checking back commodity = #{curr_back_commodity}"

		    			unless seller_trade_legs[curr_back_station][curr_back_commodity].has_key?('buyer_stations')
		    				puts "no buyer stations"
		    				next
		    			end

		    			# check if station sells anything back to original out station
		    			unless seller_trade_legs[curr_back_station][curr_back_commodity]['buyer_stations'].has_key?(curr_out_station)
		    				puts "no return trip to original station found"
		    				next
		    			end

		    			puts "back station = #{curr_back_station} sells commodity = #{curr_back_commodity} back to out station = #{curr_out_station}"

		    			out_leg_profit    = seller_trade_legs[curr_out_station][curr_out_commodity]['buyer_stations'][curr_back_station]['profit']
		    			back_leg_profit   = seller_trade_legs[curr_back_station][curr_back_commodity]['buyer_stations'][curr_out_station]['profit']

		    			puts "out_leg_profit  = #{out_leg_profit}"
		    			puts "back_leg_profit = #{back_leg_profit}"

		    			loop_total_profit = out_leg_profit + back_leg_profit

		    			puts "loop_total_profit = #{loop_total_profit}"

		    			if loop_total_profit > min_profit_per_loop
		    				puts "found trade loop between out station #{curr_out_station} commodity #{curr_out_commodity} and back station #{curr_back_station} commodity #{curr_back_commodity} for total profit #{loop_total_profit}"

		    				# now we need a hash structure that removes duplication of routes
		    				# maybe order alphabetically?

		    				temp_hash = {
		    					'stations' => {
			    					curr_out_station => {
			    						'commodity' => curr_out_commodity,
		    							'leg_profit' => out_leg_profit
			    					},
			    					curr_back_station => {
			    						'commodity' => curr_back_commodity,
		    							'leg_profit' => back_leg_profit
			    					}
			    				}
		    				}

		    				temp_hash_station_keys  = temp_hash['stations'].keys.sort
		    				from_station            = temp_hash_station_keys[0]
		    				to_station              = temp_hash_station_keys[1]

		    				from_station_hash       = temp_hash['stations'][from_station]
		    				to_station_hash         = temp_hash['stations'][to_station]

		    				distance_ly = self.calculate_distance_between_station_names(from_station, to_station)

								if ( distance_ly <= max_distance )

			    				# need to check if this combination already exists
			    				unless two_station_trade_routes.has_key?(from_station)
			    					two_station_trade_routes[from_station] = {
			    						# nav_ls => ?,
			    					}
			    				end

			    				unless two_station_trade_routes[from_station].has_key?(to_station)
			    					two_station_trade_routes[from_station][to_station] = {
			    						# nav_ls => ?,
			    					}
			    				end

			    				from_commodity = from_station_hash['commodity']

			    				unless two_station_trade_routes[from_station][to_station].has_key?(from_commodity)
			    					two_station_trade_routes[from_station][to_station][from_commodity] = {
			    						# 'leg_profit' => from_station_hash['leg_profit'],
			    					}
			    				end

			    				to_commodity = to_station_hash['commodity']

			    				unless two_station_trade_routes[from_station][to_station][from_commodity].has_key?(to_commodity)
										two_station_trade_routes[from_station][to_station][from_commodity][to_commodity] = {
			    						# 'leg_profit' => from_station_hash['leg_profit'],
			    						'distance_ly' => distance_ly,
			    						'loop_total_profit' => loop_total_profit
			    					}
			    				end # end unless has key commodity
			    			end # end if distance
		    			end
						end
	        end
		    end
			end

			return two_station_trade_routes
		end

end
