class GovernmentsController < ApplicationController
    def new
        @government = Government.new
    end

    def create
        @government = Government.new(government_params)

        if @government.save
            redirect_to @government
        else
            render 'new'
        end
    end

    def show
        @government = Government.find_by_id(params[:id])
    end

    def edit
        @government = Government.find_by_id(params[:id])
    end

    def update
      @government = Government.find(params[:id])

      if @government.update(government_params)
        redirect_to @government
      else
        render 'edit'
      end
    end

    def destroy
      @government = Government.find(params[:id])
      @government.destroy

      redirect_to governments_path
    end

    def index
        @governments = Government.all
    end

    private
        def government_params
            params.require(:government).permit(:name)
        end
end
