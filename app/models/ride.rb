class Ride < ApplicationRecord
    belongs_to :warehouse
    belongs_to :vehicle
    belongs_to :working_day
    belongs_to :driver
end
