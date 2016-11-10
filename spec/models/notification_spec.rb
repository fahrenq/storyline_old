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
  it { should validate_presence_of(:users) }

  # associations
  it { should have_many(:users).through(:notification_recipients) }

  describe 'read_by? mehtod' do
    let(:notification) { create(:notification, users: [create(:user)]) }
    it 'returns true' do
      notification_recipient = create(:notification_recipient, notification: notification, read: true)
      expect(notification.read_by?(notification_recipient.user)).to be_truthy
    end
    it 'returns false' do
      notification_recipient = create(:notification_recipient, notification: notification)
      expect(notification.read_by?(notification_recipient.user)).to be_falsy
    end
  end
end
