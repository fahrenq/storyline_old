# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  body       :string
#  category   :integer          default("new_moment")
#  info       :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Notification, type: :model do
  # validations

  # associations
  it { should have_many(:users).through(:notification_recipients) }

end
