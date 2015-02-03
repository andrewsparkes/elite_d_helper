class StationsController < ApplicationController
	def new
		@station = Station.new
	end

	def create
		@station = Station.new(station_params)

	  	if @station.save
	  		redirect_to @station
	  	else
	  		render 'new'
	  	end
	end

	def show
		@station = Station.find_by_id(params[:id])
	end

	def edit
	    @station = Station.find_by_id(params[:id])
	end

	def update
	  @station = Station.find(params[:id])

	  if @station.update(station_params)
	    redirect_to @station
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @station = Station.find(params[:id])
	  @station.destroy

	  redirect_to stations_path
	end

	def index
		@stations = Station.all
	end

	def buyers_for_supply
		@station = Station.find_by_id(params[:id])

		@possible_trades = @station.buyers_for_supply

		render 'buyers_for_supply'
	end

	def who_sells_commodity

		commodity = params[:commodity]
		commodity_id = commodity['commodity_id']

		@possible_sellers = Station.who_sells_commodity(commodity_id)

		@commodity = Commodity.find_by_id(commodity_id)

		render 'who_sells_commodity'
	end

	def trade_routes
		avail_cargo_space = params[:cargo_space]
		@possible_trade_routes = Station.calculate_all_possible_trade_routes(avail_cargo_space)

		render 'trade_routes'
	end

	private
	    def station_params
		  params.require(:station).permit(
			:system_id,
			:station_type_id,
			:name,
			:allegiance_id,
			:government_id,
			:population_level_id,
			:has_commodities,
			:has_refuel,
			:has_repair,
			:has_re_arm,
			:has_outfitting,
			:has_shipyard,
			:has_blackmarket,
			:nav_ls,
			:is_economy_agricultural,
			:is_economy_extraction,
			:is_economy_hi_tech,
			:is_economy_industrial,
			:is_economy_military,
			:is_economy_none,
			:is_economy_refinery,
			:is_economy_service,
			:is_economy_terraforming,
			:is_economy_tourism
		  )
		end
end

