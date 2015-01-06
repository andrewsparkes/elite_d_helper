class CommodityType < ActiveRecord::Base
	has_many :commodities, inverse_of: :commodity_type

	# must be unique on name and order_num
	validates :name, presence: true, uniqueness: true
	validates :order_num, presence: true, uniqueness: true, numericality: { only_integer: true }
end
