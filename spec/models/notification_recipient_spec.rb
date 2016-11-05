require 'rails_helper'

describe NotificationRecipient, type: :model do
  it { should belong_to :user }
  it { should belong_to :notification }
end
