class Address < ApplicationRecord
    has_many :order
    after_validation :geocode

    geocoded_by :address
    def address
        [street, city, state, country].compact.join(', ')
    end
end
