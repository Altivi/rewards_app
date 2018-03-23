FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password '123123'
    name { Faker::Name.first_name + ' ' + Faker::Name.last_name }
    trait :with_session do
      after(:create) do |instance|
        instance.sessions.create
      end
    end
  end
end