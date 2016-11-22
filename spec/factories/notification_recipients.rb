# == Schema Information
#
# Table name: notification_recipients
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notification_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  read            :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :notification_recipient do
    association :notification
    association :user, factory: :user
    read false
  end
end
