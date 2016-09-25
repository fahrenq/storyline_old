FactoryGirl.define do
  factory :story do
    title 'Title from FactoryGirl'
    description 'Description from FactoryGirl'
    association :user
  end
end
