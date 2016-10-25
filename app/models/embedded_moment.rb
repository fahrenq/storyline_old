class EmbeddedMoment < ApplicationRecord
  belongs_to :story

  validates :body, presence: true
end
