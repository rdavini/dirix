class Address < ApplicationRecord
    has_many :orders
    after_validation :address_to_coords
    store_accessor :location, :lat, :lng

    def address
        [street, "#{number} - #{state}", city, country].compact.join(', ')
    end

    def address_short
        ["#{street} #{number}", block, city].compact.join(', ')
    end

    private
    def address_to_coords
        self.location ||= Google::GeocodingAPI.convert self.address
    end
end
