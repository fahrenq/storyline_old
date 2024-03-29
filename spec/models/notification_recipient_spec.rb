# == Schema Information
#
# Table name: notification_recipients
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notification_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  read            :boolean          default(FALSE)
#

require 'rails_helper'

describe NotificationRecipient, type: :model do
  it { should belong_to :user }
  it { should belong_to :notification }

  it { expect(subject.read).to eq(false) }
end
