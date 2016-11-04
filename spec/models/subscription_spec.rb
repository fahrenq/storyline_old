require 'rails_helper'

describe Subscription, type: :model do
  it { should belong_to :user }
  it { should belong_to :story }
end
