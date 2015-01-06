class System < ActiveRecord::Base
	belongs_to :alliance, inverse_of: :systems
	has_many :stations, inverse_of: :system

	validates :alliance, presence: true

	validates :name, presence: true, uniqueness: true
end
