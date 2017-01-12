# == Schema Information
#
# Table name: native_moments
#
#  id                   :integer          not null, primary key
#  body                 :text
#  story_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

FactoryGirl.define do
  factory :native_moment do
    body "Body Description From Factory Girl"
    association :story
    happened_at Time.now
  end
end
