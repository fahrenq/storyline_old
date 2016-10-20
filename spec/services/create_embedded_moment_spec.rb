require 'rails_helper'

describe CreateEmbeddedMoment do
  describe 'oembed calls' do
    it 'twitter' do
      twitter_oembed = instance_double(TwitterOEmbed)
      expect(TwitterOEmbed).to receive(:new).with({ src: 'mysrc' })
      expect(twitter_oembed).to receive(:fetch).with('mysrc')
      subject.new({ src: 'mysrc' }).call
    end
  end
  it 'changes database on successful request' do
    twitter_oembed = instance_double(TwitterOEmbed)
    allow(twitter_oembed).to receive(:call) { Hash.new }
    expect {
      twitter_oembed.call
    }.to change(EmbeddedMoment, :count).by(1)
  end
  describe 'does not change database on unseccessful request' do
    twitter_oembed = instance_double(TwitterOEmbed)
    allow(twitter_oembed).to receive(:call) { nil }
    expect {
      twitter_oembed.call
    }.not_to change(EmbeddedMoment, :count)
  end
end
