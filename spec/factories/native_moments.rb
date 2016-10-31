# == Schema Information
#
# Table name: native_moments
#
#  id         :integer          not null, primary key
#  body       :text
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :native_moment do
    body "Body Description From Factory Girl"
    association :story
  end
end
