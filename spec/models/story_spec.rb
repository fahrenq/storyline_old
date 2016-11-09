# == Schema Information
#
# Table name: stories
#
#  id                   :integer          not null, primary key
#  title                :string
#  description          :text
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'rails_helper'
require 'paperclip/matchers'

describe Story, type: :model do
  # validations
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(4) }
  it { should validate_length_of(:title).is_at_most(72) }
  it { should validate_length_of(:description).is_at_least(4) }
  it { should validate_length_of(:description).is_at_most(4128) }
  it { should validate_attachment_content_type(:picture)
              .allowing('image/png', 'image/jpeg', 'image/gif')
              .rejecting('text/plain', 'text/xml') }
  it { should have_attached_file(:picture) }

  # associations
  it { should belong_to :user }
  it { should have_many(:moments).dependent(:destroy) }
  it { should have_many(:subscribers).through(:subscriptions) }
end
