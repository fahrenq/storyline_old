# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Story, type: :model do
  # validations
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(4) }
  it { should validate_length_of(:title).is_at_most(72) }
  it { should validate_length_of(:description).is_at_least(4) }
  it { should validate_length_of(:description).is_at_most(4128) }

  # associations
  it { should belong_to :user }
  it { should have_many(:native_moments).dependent(:destroy) }
end
