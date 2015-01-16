class PopulationLevelsController < ApplicationController
    def new
        @population_level = PopulationLevel.new
    end

    def create
        @population_level = PopulationLevel.new(population_level_params)

        if @population_level.save
            redirect_to @population_level
        else
            render 'new'
        end
    end

    def show
        @population_level = PopulationLevel.find_by_id(params[:id])
    end

    def edit
        @population_level = PopulationLevel.find_by_id(params[:id])
    end

    def update
      @population_level = PopulationLevel.find(params[:id])

      if @population_level.update(population_level_params)
        redirect_to @population_level
      else
        render 'edit'
      end
    end

    def destroy
      @population_level = PopulationLevel.find(params[:id])
      @population_level.destroy

      redirect_to population_levels_path
    end

    def index
        @population_levels = PopulationLevel.all
    end

    private
        def population_level_params
            params.require(:population_level).permit(:name)
        end
end
