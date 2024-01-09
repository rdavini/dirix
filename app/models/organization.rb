class Organization < ApplicationRecord
    has_many :orders

    has_many :drivers, class_name: 'Driver', :foreign_key => 'organization_id'
    has_many :warehouses
    has_many :vehicles
end
