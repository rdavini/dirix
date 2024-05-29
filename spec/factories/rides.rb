FactoryBot.define do
  factory :ride do
    association :working_day
    association :vehicle
    association :driver
    association :warehouse
  end
end