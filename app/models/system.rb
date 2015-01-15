class System < ActiveRecord::Base
	belongs_to :allegiance, inverse_of: :systems
	has_many :stations, inverse_of: :system

	validates :allegiance, presence: true

	validates :name, presence: true, uniqueness: true
end
