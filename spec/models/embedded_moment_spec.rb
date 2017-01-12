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

require 'rails_helper'

describe EmbeddedMoment, type: :model do
  # validations
  it { should validate_presence_of(:json_body) }
  it { should validate_presence_of(:happened_at) }
  # associations
  it { should belong_to(:story) }
end
