# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Story < ApplicationRecord
  belongs_to :user
  has_many :moments, dependent: :destroy

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title,
            presence: true,
            length: { in: 4..72 }

  validates :description,
            presence: true,
            length: { in: 4..4128 }

  delegate :embedded_moments, :native_moments, to: :moments
end
