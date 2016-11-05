require 'rails_helper'

describe Notification, type: :model do
  # validations
  it { should validate_presence_of(:body) }

  # associations
  it { should have_many(:users).through(:notification_recipients) }

end
