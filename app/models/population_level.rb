class PopulationLevel < ActiveRecord::Base
    has_many :stations, inverse_of: :population_level

    validates :name, presence: true, uniqueness: true
end
