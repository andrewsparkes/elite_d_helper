class AllegiancesController < ApplicationController
	def new
		@allegiance = Allegiance.new
	end

	def create
		@allegiance = Allegiance.new(allegiance_params)

	  	if @allegiance.save
	  		redirect_to @allegiance
	  	else
	  		render 'new'
	  	end
	end

	def show
		@allegiance = Allegiance.find_by_id(params[:id])
	end

	def edit
	    @allegiance = Allegiance.find_by_id(params[:id])
	end

	def update
	  @allegiance = Allegiance.find(params[:id])

	  if @allegiance.update(allegiance_params)
	    redirect_to @allegiance
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @allegiance = Allegiance.find(params[:id])
	  @allegiance.destroy

	  redirect_to allegiances_path
	end

	def index
		@allegiances = Allegiance.all
	end

	private
		def allegiance_params
			params.require(:allegiance).permit(:name)
		end
end
