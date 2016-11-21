# == Schema Information
#
# Table name: notification_recipients
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notification_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class NotificationRecipient < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  validates :user, :notification, presence: true
end
