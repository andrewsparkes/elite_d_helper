class CommodityTypesController < ApplicationController

def new
	@commodity_type = CommodityType.new
end

def create
	@commodity_type = CommodityType.new(commodity_type_params)

  	if @commodity_type.save
  		redirect_to @commodity_type
  	else
  		render 'new'
  	end
end

def show
	@commodity_type = CommodityType.find_by_id(params[:id])
end

def edit
    @commodity_type = CommodityType.find_by_id(params[:id])
end

def update
  @commodity_type = CommodityType.find(params[:id])

  if @commodity_type.update(commodity_type_params)
    redirect_to @commodity_type
  else
    render 'edit'
  end
end

def destroy
  @commodity_type = CommodityType.find(params[:id])
  @commodity_type.destroy

  redirect_to commodity_types_path
end

def index
	@commodity_types = CommodityType.all
end

private
	def commodity_type_params
		params.require(:commodity_type).permit(:name,:order_num)
	end
end
