FactoryBot.define do
  factory :api_key do
    ip { Faker::Internet.ip_v4_address }
    token { SecureRandom.hex(16) }
    association :user
  end
end
