class Organization < ApplicationRecord
    has_many :orders

    has_many :employees, class_name: 'Driver', :foreign_key => 'organization_id'

end
