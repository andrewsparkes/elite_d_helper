class Station < ActiveRecord::Base
	# system has many stations
	belongs_to :system, inverse_of: :stations
	belongs_to :station_type, inverse_of: :stations

	# station commodities
	has_many :station_commodities, inverse_of: :station
  	has_many :commodities, through: :station_commodities

	# must be unique on name
	validates :name, presence: true, uniqueness: true

	validates :system, presence: true
	validates :station_type, presence: true

	validates_inclusion_of :has_commodities, :in => [true, false]
	validates_inclusion_of :has_refuel, :in => [true, false]
	validates_inclusion_of :has_repair, :in => [true, false]
	validates_inclusion_of :has_re_arm, :in => [true, false]
	validates_inclusion_of :has_outfitting, :in => [true, false]
	validates_inclusion_of :has_shipyard, :in => [true, false]

	SQL_SOURCE_SELLS = <<-ENDSQL
		SELECT commodities.name AS commodity_name,
		station_commodities.commodity_id,
		station_commodities.demand_or_supply_level,
		station_commodities.buy_or_sell_price,
		commodity_types.name AS commodity_type_name,
		commodities.commodity_type_id,
		commodities.galactic_average_price
		FROM station_commodities
		JOIN commodities ON commodities.id = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id = commodities.commodity_type_id
		WHERE station_commodities.station_id = ?
		AND station_commodities.demanded_or_supplied = 'S'
		ORDER BY station_commodities.commodity_id;
	ENDSQL

	SQL_DEMAND_BUYS = <<-ENDSQL
		SELECT systems.id AS system_id,
		systems.name AS system_name,
		stations.id AS station_id,
		stations.name AS station_name,
		station_commodities.demand_or_supply_level,
		station_commodities.buy_or_sell_price
		FROM station_commodities
		JOIN stations ON stations.id = station_commodities.station_id
		JOIN systems ON systems.id = stations.system_id
		WHERE station_commodities.station_id != ?
		AND station_commodities.demanded_or_supplied = 'D'
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
		station_commodities.demand_or_supply_level AS seller_sell_level,
		station_commodities.buy_or_sell_price AS seller_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.demanded_or_supplied = 'S'
		) AS t_sellers
		JOIN (
		SELECT systems.name AS buyer_system_name,
		stations.name AS buyer_station_name,
		commodity_types.id AS buyer_commodity_type_id,
		commodity_types.name AS buyer_commodity_type_name,
		commodity_types.order_num AS buyer_commodity_type_order_num,
		commodities.id AS buyer_commodity_id,
		commodities.name AS buyer_commodity_name,
		station_commodities.demand_or_supply_level AS buyer_demand_level,
		station_commodities.buy_or_sell_price AS buyer_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.demanded_or_supplied = 'D'
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
		station_commodities.demand_or_supply_level AS seller_sell_level,
		station_commodities.buy_or_sell_price AS seller_price
		FROM station_commodities
		JOIN stations ON stations.id                   = station_commodities.station_id
		JOIN systems ON systems.id                     = stations.system_id
		JOIN commodities ON commodities.id             = station_commodities.commodity_id
		JOIN commodity_types ON commodity_types.id     = commodities.commodity_type_id
		WHERE station_commodities.demanded_or_supplied = 'S'
		AND commodities.id = ?
		ORDER BY seller_price asc, seller_system_name, seller_station_name
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
			curr_supply_level           = seller_row['demand_or_supply_level']
			curr_sell_price             = seller_row['buy_or_sell_price']
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
					:supply_level           => curr_supply_level,
					:sell_price             => curr_sell_price,
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
				curr_demand_or_supply_level = buyer_row['demand_or_supply_level']
				curr_buy_or_sell_price      = buyer_row['buy_or_sell_price']

				unless trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems].has_key?(curr_system_name)
					trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems][curr_system_name] = {
						:system_id          => curr_system_id,
						:buyer_stations     => {}
					}
				end

				trades_hash[:commodity_types][curr_commodity_type_name][:seller_commodities][curr_commodity_name][:buyer_systems][curr_system_name][:buyer_stations][curr_station_name] = {
					:station_id             => curr_station_id,
					:demand_or_supply_level => curr_demand_or_supply_level,
					:buy_or_sell_price      => curr_buy_or_sell_price
				}

			end
			buyer_st.close
		end

		seller_st.close

		return trades_hash
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

	def self.calculate_all_trade_routes

		display_array = []

		results = ActiveRecord::Base.connection.execute(SQL_ALL_TRADES)
		results.each do |row|
			display_array.push(row)
		end

		return display_array
	end

	def self.calculate_possible_trade_routes
		# Inputs:
		# Min value commodity (default 100) MIN_COMM_VAL
		# Profit threshold per leg MIN_PROFIT_PER_LEG
		# Profit threshold per loop MIN_PROFIT_PER_LOOP
		# (station LS from jump-in)

		# --

		# stations sell commodities at price x

		# SQL : select stations, commodities, commodity_type and sell price where demand_or_sell 'S' and sell_price > MIN_COMM_VAL

		# data structure:

		# stations { station_name { sells_commodities { commodity_name { price }}}}

		# --

		# stations buy commodities at price y

		# SQL : select stations, commodities, commodity_type and buy price where demand_or_sell 'D' and buy_price > MIN_COMM_VAL

		# data structure:

		# stations { station_name { 'buys_commodities' { commodity_name { 'price' => price }}}}

		# --

		# so now have:
		# stations { station_name { 'sells_commodities' { commodity_name { 'price' => price }}, 'buys_commodities' { commodity_name { 'price' => price }}}}

		# --

		# trade_legs = {}

		# get array sorted keys in stations

		# stations_array.each do |curr_seller_station|
		#     next unless stations[curr_seller_station][sells_commodities]
		#     get array_sell_commodities by sorted keys in stations[curr_seller_station][sells_commodities]
		#     array_sell_commodities.each do |curr_seller_commodity|
		#         # find any buyers
		#         stations_array.each do |curr_buyer_station|
		#             ignore if no stations[curr_buyer_station][buys_commodities]
		#             if exists stations[curr_buyer_station][buys_commodities][curr_seller_commodity]
		#                 # calculate potential profit
		#                 profit = stations[curr_buyer_station][buys_commodities][curr_seller_commodity][price] - stations[curr_seller_station][sells_commodities][curr_seller_commodity][price]
		#                 if profit > MIN_PROFIT_PER_LEG
		#                     # store potential trade leg
		#                     # station_from, buy_price, station_to, sell_price, commodity, profit
		#                     trade_legs[station_from][commodity][station_to] = { 'profit' => profit }
		#                 end
		#             end
		#         end
		#     end
		# end

		# --

		# # so now have hash of trade legs, and need to match them up

		# trade_legs {
		#     Leesti {
		#         Progenitor Cells {
		#             HIP 65636 {
		#                 profit = 973
		#             }
		#         }
		#     },
		#     HIP 65636 {
		#         Palladium {
		#             Leesti {
		#                 profit = 1512
		#             }
		#         }
		#     }
		# }

		# --

		# trade_routes = {}

		# array_starting_stations = sorted keys trade_legs
		# array_starting_stations.each do |curr_starting_station|

		#     array_starting_station_commodities = sorted keys trade_legs[curr_starting_station]
		#     array_starting_station_commodities.each do |curr_commodity|

		#         array_ending_stations = sorted_keys trade_legs[curr_starting_station]|curr_commodity|
		#         array_ending_stations.each do |curr_ending_station|

		#             # no search for trade leg from this ending station with any commodity to station matching the curr_starting_station
		#             # if we find one we have a trade loop
		#             # calculate loop profit
		#             # if loop profit > MIN_PROFIT_PER_LOOP
		#                   # add the trade loop to a hash (unless reverse loop is already present!)

		#         end
		#     end
		# end



		# trade_loops {
		#     from_station {
		#         to_station {
		#             from_commodity {
		#                 to_commodity {
		#                     profit
		#                 }
		#             }
		#         }
		#     }
		# }

		# e.g
		# trade_loops {
		#     Leesti {
		#         HIP 65636 {
		#             Progenitor Cells {
		#                 Palladium {
		#                     profit = 2512
		#                 },
		#                 Gold {
		#                     profit = 2314
		#                 }
		#             },
		#             Consumer Tech {
		#                 Palladium {
		#                     profit = 2437
		#                 },
		#                 Gold {
		#                     profit = 2261
		#                 }
		#             }
		#         }
		#     }
		# }

		# # need to order output by profit then out commodity then back commodity
		# # could store in table with composite key of from_station, to_station, from_commodity, to_commodity with profit as 5th column

		# Leesti (264 LS) -> HIP 65636 (47 LS)
		# Out: Progenitor Cells   Back: Palladium     Profit: 2512
		# Out: Consumer Tech      Back: Palladium     Profit: 2437
		# Out: Progenitor Cells   Back: Gold          Profit: 2314
		# Out: Consumer Tech      Back: Gold          Profit: 2261


		# ==========================
		# http://edstarcoordinator.com/api.html


		# Please note that the API uses

		# type: 'POST'
		# contentType: 'application/json; charset=utf-8'


		# GetSystems
		# Get a list of systems

		# Request

		# Method  URL
		# POST    api.asmx/GetSystems
		# TYPE    Params                  Values
		# POST    ver                     int (>=1)
		# POST    test                    bool        [Optional][Default:false]
		# POST    outputmode              int (1/2)   [Optional][Default:1]
		# POST    filter                  Object containing all filter options [Optional]
		# POST    knownstatus [filter]    int (0/1/2) [Optional][Default:0]
		# POST    systemname [filter]     string [Optional]
		# POST    cr [filter]             int (>=0) [Optional][Default:5]
		# POST    date [filter]           "yyyy-MM-dd hh:mm:ss" || "yyyy-MM-dd" [Optional][Default: Now-24h]
		# POST    coordcube [filter]      [[xmin,xmax][ymin,ymax][zmin,zmax]] [Optional] min is inclusive ">=", max is exlusive "<"
		# POST    coordsphere [filter]    {radius:xxx.xx, origin:[x,y,z]} [Optional] radius is inclusive ">="


		# ver
		# ver must be send with all requests. Only the Major version number.
		# Minor version numbers of the API are always backwards compatible with the Major version.

		# test
		# When test is true all queries are directed at a test DB.
		# The test DB is a mirror of the non-test DB and is beeing mirrored every 24 hours at 1:15 UTC
		# Please use the test flag when developing your apps, so we get as little trash as possible in the non-test DB.

		# outputmode
		# outputmode can be used to reduce bandwidth, as not all possible info is always required. A simple (Terse) list of names is fine for a dropdown list.
		# 1 (Terse) - Returns only the names of the systems
		# 2 (Verbose) - Returns id, name, coords, cr, who and when created/updated the system last.

		# filter
		# filter is an object wrapping the individual filter options

		# knownstatus
		# knownstatus filters on if a systems coordinates are known or not
		# 0 (All) Default - Returns all systems, ie. "no filter".
		# 1 (Known) - Returns only systems with known coordinates.
		# 2 (Unknown) - Returns only systems not having known coordinates.

		# systemname
		# systemname Limit search to systems with names containing systemname

		# cr
		# cr Confidence Rating. How many times have an entry been confirmed.
		# With a cr of 1 it could be a mis-typed system name. The chance of which is reduced with a higher cr number. Records with a cr equal or higher than the supplied value are returned.

		# date
		# date Date of last update.
		# date is an UTC date.
		# Records with an update date equal or higher than date are returned.
		# Suggested use is to keep note of your last pull, and then only request records newer than that timestamp.

		# coordcube
		# coordcube limits the results to those starsystems contained by the defined cube

		# coordsphere
		# coordsphere Limits the result to those starsystems within the given radius of the origin

		# Example code

		# Code example
		# Complete copy/paste ready code (Requires jQuery) - JSFiddle

		# function getSystemData(){
		# //var data = {data: {ver:2}}; //Just one required parameter - Simplest possible
		# var data = {
		#   data: {
		#     ver:2,
		#     test: true,
		#     outputmode:1,
		#     filter:{
		#         knownstatus:0,
		#         systemname: "sol",
		#         cr:5,
		#         date:"2014-09-18 12:34:56",
		#         coordcube: [[-10,10],[-10,10],[-10,10]],
		#         coordsphere: {radius: 123.45, origin: [10,20,30]}
		#     }
		#   }
		# };

		# $.ajax({
		#   type: 'POST',
		#   contentType: 'application/json; charset=utf-8',
		#   url: 'api.asmx/GetSystems',
		#   data: JSON.stringify(data),
		#   dataType: 'json',
		#   success:
		#     function(data){
		#       submitsuccess(data.d);
		#     },
		#   error: submiterror
		# });
		# };

		# function submitsuccess(data){}

		# function submiterror(d,a){}






		# An example response is:-
		#   {
		#     ver: 2.0,
		#     date: "2014-11-08 19:57:37",
		#     status: {
		#       input: [
		#         {
		#           status: {
		#             statusnum: 0,
		#             msg: "Success"
		#           }
		#         }
		#       ]
		#     },
		#     systems: [
		#       {
		#         id: 222,
		#         name: "10 Canum Venaticorum",
		#         coord: [
		#           -9.375,
		#           55.4375,
		#           -7
		#         ],
		#         cr: 5,
		#         commandercreate: "",
		#         createdate: "2014-11-07 13:38:07",
		#         commanderupdate: "",
		#         updatedate: "2014-11-07 13:38:07"
		#       },
		#       {
		#         id: 254,
		#         name: "10 Ursae Majoris",
		#         coord: [
		#           0.03125,
		#           34.90625,
		#           -39.09375
		#         ],
		#         cr: 5,
		#         commandercreate: "",
		#         createdate: "2014-11-07 13:38:07",
		#         commanderupdate: "",
		#         updatedate: "2014-11-07 13:38:07"
		#       },
		#     ...
		# }

		# =====

		# Distance calculation between 2 sets of XYZ coordinates:

		# distance = root [ (X2 - X1)sqd + (Y2 - Y1)sqd + (Z2 - Z1)sqd  ]

		# In Ruby use the Math module

		# Numbers must be floats
		# Math.sqrt(5.0) = 2.23606797749979

		# Squared is N**2

		# distance = Math.sqrt( ( (X2-X1)**2 ) + ( (Y2-Y1)**2 ) + ( (Z2-Z1)**2 ) )

		# =====
		# Migration:

		# new tables:
		# add new table allegiances (id, name)
		# add new table economies (id, name)
		# add new table station_economies (station_id, economy_id) (potentially multiple economies)
		# add new table population_levels (id, name)
		# add new table governments (id, name)

		# add field systems.eds_id (int, NULL)
		# add field systems.x (float, NULL)
		# add field systems.y (float, NULL)
		# add field systems.z (float, NULL)
		# add field systems.allegiance_id (int, NULL)
		# add field systems.government_id (int, NULL)
		# add field stations.allegiance_id (int, NULL)
		# add field stations.population_level_id (int, NULL)
		# add field stations.government_id (int, NULL)
		# add field stations.has_blackmarket (boolean, NULL)

		# drop field systems.alliance_id
		# drop alliances table




		# add 'unknown' data value to allegiance table

		# link systems to allegiances in model
		# link stations to allegiances in model

		# change all references to alliances model, view, controller to allegiances
		# remove alliances model, controller, views, tests



		# Add data controller to allow adding/updating systems in radius around system_name
		# inputs: system name, radius, api ver

		# check for existance of system by eds_id
		# if system exists
		#     check for coordinates and update if not matching
		# else
		#     insert system (name, coords, eds_id, 'unexplored' for allegiance)
		# end
		# report view shows what was done (collect array of insert/update messages)

		# system model add self.distance_between(system_name_A, system_name_B)
		# return -1 if no coords in one or both systems

		# can now do clever stuff like trade routes with distance legs < X ly



		display_array = self.calculate_all_trade_routes

		return display_array
	end
end
