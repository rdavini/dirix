FactoryBot.define do
  factory :address do    
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    number { Faker::Address.building_number }
    block { Faker::Address.community }
    country { Faker::Address.community }
    complement { Faker::Address.country }
    zip { Faker::Address.zip }
    street { Faker::Address.street_name }
    location do
      {
        "lat" => Faker::Address.latitude.to_f,
        "lng" => Faker::Address.longitude.to_f
      }
    end
  end
end