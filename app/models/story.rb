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

class Story < ApplicationRecord
  belongs_to :user

  has_many :moments, dependent: :destroy

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  has_many :notifications

  validates :title,
            presence: true,
            length: { in: 4..72 }

  validates :description,
            presence: true,
            length: { in: 4..4128 }

  has_attached_file :picture, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/picture_:style.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  delegate :embedded_moments, :native_moments, to: :moments
end
