class Address < ApplicationRecord
    has_many :orders
    after_validation :address_to_coords
    store_accessor :location, :lat, :lng

    validates :country, presence: true
    validates :zip, presence: true
    validates :number, presence: true
    validates :street, presence: true
    validates :state, presence: true
    validates :city, presence: true

    def address
        return nil unless street && number && state && city && country
        [street, "#{number} - #{state}", city, country].compact.join(', ')
    end

    def address_short
        ["#{street} #{number}", block, city].compact.join(', ')
    end

    private
    def address_to_coords
        self.location ||= Google::GeocodingAPI.convert self.address if self.address
    end
end
