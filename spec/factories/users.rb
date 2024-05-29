FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    photo { Faker::Name.name  }
    name { Faker::Name.name  }
    password { Faker::Name.name }

    after(:create) do |user|
      create(:api_key, article: user)
    end
  end
end
