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

require 'rails_helper'
require 'paperclip/matchers'

RSpec.describe NativeMoment, type: :model do
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
