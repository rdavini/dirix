FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    photo { "teste s3bucket" }
    role { "organization" }
    name { Faker::Name.name  }
    password { Faker::Name.name }
  end
end
