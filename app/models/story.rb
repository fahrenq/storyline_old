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
  has_many :native_moments, dependent: :destroy

  validates :title,
    presence: true,
    length: { in: 4..72 }

  validates :description,
    length: { in: 4..4128 }
end
