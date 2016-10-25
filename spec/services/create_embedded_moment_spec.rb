require 'rails_helper'
require 'oembedapi/twitter'

describe CreateEmbeddedMoment do
  let(:story) { create(:story) }
  let(:twitter_oembed) { instance_double(OembedApi::Twitter) }
  before { allow(OembedApi::Twitter).to receive(:new) { twitter_oembed } }

  it 'calls oembed apis twitter' do
    expect(OembedApi::Twitter).to receive(:new)
    expect(twitter_oembed).to receive(:fetch).with('mysrc')
    CreateEmbeddedMoment.new({ url: 'mysrc', service: 'twitter'}).call
  end
  it 'changes database on successful request' do
    allow(twitter_oembed).to receive(:fetch) { Hash['test', 'test'] }
    expect {
      CreateEmbeddedMoment.new({ url: 'mysrc', service: 'twitter', story_id: story.id}).call
    }.to change(EmbeddedMoment, :count).by(1)
  end
  it 'does not change database on unseccessful request' do
    allow(twitter_oembed).to receive(:fetch) { nil }
    expect {
      CreateEmbeddedMoment.new({ url: '', service: 'twitter', story_id: story.id }).call
    }.not_to change(EmbeddedMoment, :count)
  end
end
