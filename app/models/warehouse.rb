class Warehouse < ApplicationRecord
    belongs_to :organization
    belongs_to :address
end