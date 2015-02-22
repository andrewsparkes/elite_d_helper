class StationCommoditiesController < ApplicationController
	def new
		@station_commodity = StationCommodity.new
	end

	def create
		@station_commodity = StationCommodity.new(station_commodity_params)

	  	if @station_commodity.save
	  		redirect_to @station_commodity
	  	else
	  		render 'new'
	  	end
	end

	def show
		@station_commodity = StationCommodity.find_by_id(params[:id])
	end

	def edit
	    @station_commodity = StationCommodity.find_by_id(params[:id])
	end

	def update
	  @station_commodity = StationCommodity.find(params[:id])

	  if @station_commodity.update(station_commodity_params)
	    redirect_to @station_commodity
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @station_commodity = StationCommodity.find(params[:id])
	  @station_commodity.destroy

	  # redirect_to station_commodities_path
	  redirect_to @station_commodity.station
	end

	def index
		@station_commodities = StationCommodity.all
	end

	private
		def station_commodity_params
			puts "checking sc params"
			require 'pp'
			pp params
			params.require(:station_commodity).permit(:station_id,:commodity_id,:sell,:buy,:demand,:demand_level,:supply,:supply_level)
		end
end