class StationType < ActiveRecord::Base
	has_many :stations, inverse_of: :station_type

	# must be unique on name
	validates :name, presence: true, uniqueness: true

	validates_inclusion_of :has_small_dock, :in => [true, false]
	validates_inclusion_of :has_medium_dock, :in => [true, false]
	validates_inclusion_of :has_large_dock, :in => [true, false]
end
