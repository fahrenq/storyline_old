FactoryGirl.define do
  factory :notification_recipient do
    association :notification
    association :user, factory: :user
    read false
  end
end
