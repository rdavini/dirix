class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    enum role: [ :organization , :driver ]

    attr_accessor :license_plate, :vehicle_brand, :vehicle_color, :organization_id

    has_one :api_key

    has_one :driver
    has_one :organization

    validates_presence_of :email, :password
    after_create :create_api_key, :create_inherited_obj

    def get_user_info
        case self.role
        when 'organization'
            {teste: "as"}
        when 'driver'
            {teste: "as"}
        when 'rider'
            {teste: "as"}
        else
            p "Role ${self.role} has not been treated"
        end
    end
    private
    def create_api_key
        self.api_key = ApiKey.new(ip: 'localhost')
    end

    def create_inherited_obj
        case self.role
        when 'organization'
            self.organization = Organization.new
        when 'driver'
            self.driver = Driver.new( organization_id: self.organization_id || 1, #remove this 1, only for seedling
                                      license_plate: self.license_plate,
                                      vehicle_brand: self.vehicle_brand,
                                      vehicle_color: self.vehicle_color )
        else
            p "undefined role"
        end
    end
end
