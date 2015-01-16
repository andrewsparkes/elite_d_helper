class StationEconomy < ActiveRecord::Base
    belongs_to :station, inverse_of: :station_economies
    belongs_to :economy, inverse_of: :station_economies

    validates :station, presence: true
    validates :economy, presence: true
end
