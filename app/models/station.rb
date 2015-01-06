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
		# for each system, station, sell commodity:  calculate destination buyers

		# create list of source_system, source_station, commodity_type_name, commodity_name, sell_price, dest_system, dest_station, buy_price, profit
		# order by source_system, source_station, profit

		# create reduced list with best <=3 profits per source system, station
		# order by source_system, source_station, profit

		# create list of unique dest_system, dest_station from this profit list
		# order by dest_system, dest_station

		# for each dest_system, dest_station check if has source_system, source_station in profit list
		# if yes add to trade routes hash

		display_array = self.calculate_all_trade_routes

		return display_array
	end
end
