require 'rails_helper'

describe Notification, type: :model do
  # validations

  # associations
  it { should have_many(:users).through(:notification_recipients) }

end
