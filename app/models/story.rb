class Story < ApplicationRecord
  belongs_to :user
  has_many :native_moments

  validates :title, presence: true
end
