class Commodity < ActiveRecord::Base
	belongs_to :commodity_type, inverse_of: :commodities

	has_many :station_commodities, inverse_of: :commodity
  	has_many :stations, through: :station_commodities

  	validates :commodity_type, presence: true

	# must be unique on name, and price must be an integer
	validates :name, presence: true, uniqueness: true
	validates :galactic_average_price, presence: true, numericality: { only_integer: true }
end
