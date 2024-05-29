class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    enum role: [ :organization , :driver ]

    attr_accessor :organization_id

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
        #the ip should arrive on the user_creation params and a workaround for testing or development environment
        self.api_key = ApiKey.new(ip: Faker::Internet.ip_v4_address)
    end

    def create_inherited_obj
        case self.role
        when 'organization'
            self.organization = Organization.new
        when 'driver'
            self.driver = Driver.new( organization_id: self.organization_id)
        else
            p "undefined role"
        end
    end
end
