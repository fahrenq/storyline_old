class Notification < ApplicationRecord
  has_many :notification_recipients
  has_many :users, through: :notification_recipients

  # validates :body, presence: true

  enum category: [:new_moment]
end
