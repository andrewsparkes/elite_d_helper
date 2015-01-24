class System < ActiveRecord::Base
	belongs_to :allegiance, inverse_of: :systems
	belongs_to :government, inverse_of: :systems

	has_many :stations, inverse_of: :system

	validates :allegiance, presence: true
	validates :government, presence: true
	validates :name, presence: true, uniqueness: true

	# Distance calculation between 2 sets of XYZ coordinates:
	def self.distance_between_systems(systemA, systemB)

		unless systemA.x && systemA.y && systemA.z
			return nil
		end

		unless systemB.x && systemB.y && systemB.z
			return nil
		end

		distance = Math.sqrt( ( (systemB.x-systemA.x)**2 ) + ( (systemB.y-systemA.y)**2 ) + ( (systemB.z-systemA.z)**2 ) )
		distance = (distance * 100).floor / 100.0
		return distance
	end
end
