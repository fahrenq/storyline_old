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
require 'paperclip/matchers'

describe NativeMoment, type: :model do
  # validations
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_least(4) }
  it { should validate_length_of(:body).is_at_most(2048) }
  it { should validate_attachment_content_type(:picture)
              .allowing('image/png', 'image/jpeg', 'image/gif')
              .rejecting('text/plain', 'text/xml') }
  it { should have_attached_file(:picture) }

  # associations
  it { should belong_to(:story) }
end
