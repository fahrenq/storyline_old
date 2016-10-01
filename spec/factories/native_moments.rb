FactoryGirl.define do
  factory :native_moment do
    name "Name of Moment"
    body "Body Description From Factory Girl"
    association :story
  end
end
