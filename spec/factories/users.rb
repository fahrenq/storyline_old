FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "UserName#{n}" }
    sequence(:email) { |n| "samplemail_#{n}@example.com" }
    password 'pswd1234'

    factory :user_faker do
      name Faker::Internet.user_name
      email Faker::Internet.email
    end
  end
end
