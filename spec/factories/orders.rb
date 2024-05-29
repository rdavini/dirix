FactoryBot.define do
  factory :order do
    code { Faker::Name.name } 
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    distance_from_src { Faker::Number.number(digits: 1) }

    association :organization    
    association :address
    association :ride
  end
end
