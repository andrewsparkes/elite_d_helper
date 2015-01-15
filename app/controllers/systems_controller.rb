class SystemsController < ApplicationController
	def new
		@system = System.new
	end

	def create
		@system = System.new(system_params)

	  	if @system.save
	  		redirect_to @system
	  	else
	  		render 'new'
	  	end
	end

	def show
		@system = System.find_by_id(params[:id])
	end

	def edit
	    @system = System.find_by_id(params[:id])
	end

	def update
	  @system = System.find(params[:id])

	  if @system.update(system_params)
	    redirect_to @system
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @system = System.find(params[:id])
	  @system.destroy

	  redirect_to systems_path
	end

	def index
		@systems = System.all
	end

	private
		def system_params
			params.require(:system).permit(:allegiance_id,:name)
		end
end
