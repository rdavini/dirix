class Order < ApplicationRecord
    belongs_to :organization
    has_one :address
    after_create :create_address

    attr_accessor :street, :number, :block, :city, :state, :zip

    def get_status
        if self.end_time and self.start_time
            return "finalizado"
        elsif self.start_time
            return "em andamento"
        else
            return "não iniciado"
        end
    end

    private
    def create_address
        self.address = Address.new(street: street, number: number, block: block, city: city, state: state, zip: zip)
    end
end
