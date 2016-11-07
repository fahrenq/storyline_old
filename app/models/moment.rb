class Moment < ApplicationRecord
  belongs_to :story

  scope :embedded_moments, -> { where(type: 'embedded_moment') }
  scope :native_moments, -> { where(type: 'native_moment') }
end
