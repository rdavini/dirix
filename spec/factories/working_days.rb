FactoryBot.define do
  factory :working_day do
    date { Faker::Date.between(from: 2.days.ago, to: Date.today)  }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    
    association :driver
  end
end
