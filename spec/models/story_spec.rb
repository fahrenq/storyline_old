require 'rails_helper'

describe Story, type: :model do
  it { belong_to :user }
end
