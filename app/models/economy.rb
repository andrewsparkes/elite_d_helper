class Economy < ActiveRecord::Base
    has_many :stations, inverse_of: :economy

    validates :name, presence: true, uniqueness: true
end
