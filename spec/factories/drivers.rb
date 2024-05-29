FactoryBot.define do
  factory :driver do
    avg_speed { Faker::Number.number(digits: 2) }
    association :user
    association :organization
  end
end
