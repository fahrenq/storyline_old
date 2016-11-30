# == Schema Information
#
# Table name: moments
#
#  id                   :integer          not null, primary key
#  body                 :text
#  json_body            :json
#  story_id             :integer
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'rails_helper'

describe EmbeddedMoment, type: :model do
  # validations
  it { should validate_presence_of(:json_body) }
  # associations
  it { should belong_to(:story) }

  describe 'fill method' do
    let(:story) { create(:story) }
    let(:embedded_moment_new) { EmbeddedMoment.new(story: story) }
    let(:twitter_oembed) { instance_double(OembedAPI::Twitter) }
    before { allow(OembedAPI::Twitter).to receive(:new) { twitter_oembed } }
    let(:url) { 'https://twitter.com/someuser/sometweet' }

    it 'calls oembed api' do
      expect(OembedAPI::Twitter).to receive(:new)
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
