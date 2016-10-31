# == Schema Information
#
# Table name: native_moments
#
#  id         :integer          not null, primary key
#  body       :text
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NativeMoment < ApplicationRecord
  belongs_to :story

  validates :body,
            presence: true,
            length: { in: 4..2048 }
end
