class AlliancesController < ApplicationController
	def new
		@alliance = Alliance.new
	end

	def create
		@alliance = Alliance.new(alliance_params)

	  	if @alliance.save
	  		redirect_to @alliance
	  	else
	  		render 'new'
	  	end
	end

	def show
		@alliance = Alliance.find_by_id(params[:id])
	end

	def edit
	    @alliance = Alliance.find_by_id(params[:id])
	end

	def update
	  @alliance = Alliance.find(params[:id])

	  if @alliance.update(alliance_params)
	    redirect_to @alliance
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @alliance = Alliance.find(params[:id])
	  @alliance.destroy

	  redirect_to alliances_path
	end

	def index
		@alliances = Alliance.all
	end

	private
		def alliance_params
			params.require(:alliance).permit(:name)
		end
end
