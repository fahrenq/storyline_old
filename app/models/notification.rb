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

  enum category: [:new_moment]

  def self.create_for_new_moment(moment)
    create(
      users: moment.story.subscribers,
      info: { story_id: moment.story.id, story_title: moment.story.title },
      category: 'new_moment'
    )
  end
end
