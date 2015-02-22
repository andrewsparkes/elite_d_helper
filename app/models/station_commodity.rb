class StationCommodity < ActiveRecord::Base
	belongs_to :station, inverse_of: :station_commodities
	belongs_to :commodity, inverse_of: :station_commodities

	validates :station, presence: true
	validates :commodity, presence: true

	validates :buy, numericality: { only_integer: true }, :allow_nil => true
	validates :sell, numericality: { only_integer: true }, :allow_nil => true
	validates :demand, numericality: { only_integer: true }, :allow_nil => true
	validates :supply, numericality: { only_integer: true }, :allow_nil => true

	VALID_DEMAND_OR_SUPPLY_LEVEL = %w(Low Med High)
	validates_inclusion_of :demand_level, :in => VALID_DEMAND_OR_SUPPLY_LEVEL, :allow_nil => true
	validates_inclusion_of :supply_level, :in => VALID_DEMAND_OR_SUPPLY_LEVEL, :allow_nil => true

	validates_uniqueness_of :commodity_id, :scope => [:station_id]

end
