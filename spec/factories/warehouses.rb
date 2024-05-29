FactoryBot.define do
  factory :warehouse do
    name { Faker::Name.name }    
    
    association :organization
    association :address
  end
end
