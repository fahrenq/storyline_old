class Notification < ApplicationRecord
  has_many :notification_recipients
  has_many :users, through: :notification_recipients

  enum category: [:new_moment]

  def self.create_for_new_moment(moment)
    create(
      users: moment.story.subscribers,
      info: { story_id: moment.story.id, story_title: moment.story.title },
      category: 'new_moment'
    )
  end
end
