class CommoditiesController < ApplicationController

def new
	@commodity = Commodity.new
end

def create
	@commodity = Commodity.new(commodity_params)

  	if @commodity.save
  		redirect_to @commodity
  	else
  		render 'new'
  	end
end

def show
	@commodity = Commodity.find_by_id(params[:id])
end

def edit
    @commodity = Commodity.find_by_id(params[:id])
end

def update
  @commodity = Commodity.find(params[:id])

  if @commodity.update(commodity_params)
    redirect_to @commodity
  else
    render 'edit'
  end
end

def destroy
  @commodity = Commodity.find(params[:id])
  @commodity.destroy

  redirect_to commodities_path
end

def index
	@commodities = Commodity.all
end

private
	def commodity_params
		params.require(:commodity).permit(:name,:commodity_type_id,:galactic_average_price)
	end

end
