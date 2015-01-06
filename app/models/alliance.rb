class Alliance < ActiveRecord::Base
	has_many :systems, inverse_of: :alliance

	validates :name, presence: true, uniqueness: true
end
