class StationCommodity < ActiveRecord::Base
	belongs_to :station, inverse_of: :station_commodities
	belongs_to :commodity, inverse_of: :station_commodities

	validates :station, presence: true
	validates :commodity, presence: true

	VALID_DEMANDED_OR_SUPPLIED = %w(D S)
	validates_inclusion_of :demanded_or_supplied, :in => VALID_DEMANDED_OR_SUPPLIED

	VALID_DEMAND_OR_SUPPLY_LEVEL = %w(L M H)
	validates_inclusion_of :demand_or_supply_level, :in => VALID_DEMAND_OR_SUPPLY_LEVEL

	validates :buy_or_sell_price, presence: true, numericality: { only_integer: true }
	validates_uniqueness_of :commodity_id, :scope => [:station_id]

end
