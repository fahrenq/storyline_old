# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  body       :string
#  category   :integer          default("new_moment")
#  info       :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    body 'MyString'
    category :new_moment
    # info {
    #   {
    #     'story_id'    => 1,
    #     'story_title' => 'MyTitle'
    #   }
    # }
    association :story
  end
end
