class EmbeddedMoment < ApplicationRecord
  SERVICES = ['twitter', 'youtube']
  belongs_to :story

  validates :body, presence: true
end
