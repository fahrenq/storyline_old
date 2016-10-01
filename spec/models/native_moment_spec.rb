require 'rails_helper'

RSpec.describe NativeMoment, type: :model do
  it { belong_to :story }
end
