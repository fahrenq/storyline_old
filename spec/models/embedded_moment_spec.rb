# == Schema Information
#
# Table name: embedded_moments
#
#  id         :integer          not null, primary key
#  body       :json
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'
require 'oembedapi/handler'
require 'oembedapi/twitter'

describe EmbeddedMoment, type: :model do
  # validations
  it { should validate_presence_of(:body) }
  # associations
  it { should belong_to(:story) }

  describe 'fill method' do
    let(:story) { create(:story) }
    let(:embedded_moment_new) { EmbeddedMoment.new(story: story) }
    let(:twitter_oembed) { instance_double(OembedApi::Twitter) }
    before { allow(OembedApi::Twitter).to receive(:new) { twitter_oembed } }
    let(:url) { 'https://twitter.com/someuser/sometweet' }

    it 'calls oembed api' do
      expect(OembedApi::Twitter).to receive(:new)
      expect(twitter_oembed).to receive(:fetch).with(url)
      embedded_moment_new.fill({ url: url })
    end
    it 'changes database on successful request' do
      allow(twitter_oembed).to receive(:fetch) { Hash['test', 'test'] }
      expect {
        embedded_moment_new.fill({ url: url })
      }.to change(EmbeddedMoment, :count).by(1)
    end
    it 'does not change database on unsuccessful request' do
      allow(twitter_oembed).to receive(:fetch) { nil }
      expect {
        embedded_moment_new.fill({ url: url })
      }.not_to change(EmbeddedMoment, :count)
    end
  end
end
