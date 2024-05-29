FactoryBot.define do
  factory :vehicle do
    model { Faker::Vehicle.model }
    brand { Faker::Vehicle.make }
    color { Faker::Vehicle.color }
    license_plate { Faker::Vehicle.license_plate }
    vehicle_doc_photo { Faker::Name.name }

    association :organization
  end
end
