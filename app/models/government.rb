class Government < ActiveRecord::Base
    has_many :stations, inverse_of: :government
    has_many :systems, inverse_of: :government

    validates :name, presence: true, uniqueness: true
end
