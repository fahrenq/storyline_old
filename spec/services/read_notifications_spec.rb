require 'rails_helper'

describe ReadNotifications do
  let(:user) { create(:user) }
  let(:notifications) { create_list(:notification, 10, users: [user]) }
  subject { ReadNotifications.new(notifications, user) }
  it 'set all notifications of user read status' do
    subject.call
    expect(user.notifications.all? { |n| n.read_by?(user) }).to be_truthy
  end
end
