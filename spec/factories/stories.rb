# == Schema Information
#
# Table name: stories
#
#  id                   :integer          not null, primary key
#  title                :string
#  description          :text
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

FactoryGirl.define do
  factory :story do
    title 'Title from FactoryGirl'
    description 'Description from FactoryGirl'
    association :user
  end
end
