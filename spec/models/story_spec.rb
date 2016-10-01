require 'rails_helper'

describe Story, type: :model do
  it { belong_to :user }
  it { have_many :native_moment }
end
