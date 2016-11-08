# == Schema Information
#
# Table name: moments
#
#  id                   :integer          not null, primary key
#  body                 :text
#  json_body            :json
#  story_id             :integer
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Moment < ApplicationRecord
  belongs_to :story

  scope :embedded_moments, -> { where(type: 'embedded_moment') }
  scope :native_moments, -> { where(type: 'native_moment') }
end
