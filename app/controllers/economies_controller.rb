class EconomiesController < ApplicationController
    def new
        @economy = Economy.new
    end

    def create
        @economy = Economy.new(economy_params)

        if @economy.save
            redirect_to @economy
        else
            render 'new'
        end
    end

    def show
        @economy = Economy.find_by_id(params[:id])
    end

    def edit
        @economy = Economy.find_by_id(params[:id])
    end

    def update
      @economy = Economy.find(params[:id])

      if @economy.update(economy_params)
        redirect_to @economy
      else
        render 'edit'
      end
    end

    def destroy
      @economy = Economy.find(params[:id])
      @economy.destroy

      redirect_to economies_path
    end

    def index
        @economies = Economy.all
    end

    private
        def economy_params
            params.require(:economy).permit(:name)
        end
end
