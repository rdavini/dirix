class Address < ApplicationRecord
    has_many :orders
    after_validation :address_to_coords

    def address
        [street, "#{number} - #{state}", city, country].compact.join(', ')
    end

    def address_short
        ["#{street} #{number}", block, city].compact.join(', ')
    end

    private
    def address_to_coords
        return if self.latitude != nil
        coords = Google::GeocodingAPI.new.convert self.address
        self.latitude = coords["lat"]
        self.longitude = coords["lng"]
    end
end
