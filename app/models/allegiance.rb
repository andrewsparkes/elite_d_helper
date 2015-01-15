class Allegiance < ActiveRecord::Base
    has_many :systems, inverse_of: :allegiance
    has_many :stations, inverse_of: :allegiance

    validates :name, presence: true, uniqueness: true
end
