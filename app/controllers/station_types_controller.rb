class StationTypesController < ApplicationController
	def new
		@station_type = StationType.new
	end

	def create
		@station_type = StationType.new(station_type_params)

	  	if @station_type.save
	  		redirect_to @station_type
	  	else
	  		render 'new'
	  	end
	end

	def show
		@station_type = StationType.find_by_id(params[:id])
	end

	def edit
	    @station_type = StationType.find_by_id(params[:id])
	end

	def update
	  @station_type = StationType.find(params[:id])

	  if @station_type.update(station_type_params)
	    redirect_to @station_type
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @station_type = StationType.find(params[:id])
	  @station_type.destroy

	  redirect_to station_types_path
	end

	def index
		@station_types = StationType.all
	end

	private
		def station_type_params
			params.require(:station_type).permit(:name,:has_small_dock,:has_medium_dock,:has_large_dock)
		end
end
