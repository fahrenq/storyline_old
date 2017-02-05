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

class Notification < ApplicationRecord
  has_many :notification_recipients
  has_many :users, through: :notification_recipients
  belongs_to :story

  validates_presence_of :users

  enum category: [:new_moment]

  scope :for_user, lambda { |user| includes(:story, notification_recipients: :user)
                                   .where(notification_recipients: { user: user }) }

  def self.create_for_new_moment(moment)
    new(
      users: moment.story.subscribers,
      story: moment.story,
      # info: { story_id: moment.story.id, story_title: moment.story.title },
      category: 'new_moment'
    ).save
  end

  def read_by?(user)
    # not using find_by here, because it hits database
    notification_recipients.find { |n| n.user == user }.read?
  end
end
