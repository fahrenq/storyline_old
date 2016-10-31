require 'rails_helper'
require 'oembedapi/handler'
require 'oembedapi/twitter'

describe OembedApi::Handler do
  context 'choose api to call' do
    it 'with url protocol' do
      expect(OembedApi::Twitter).to receive(:new)
      OembedApi::Handler.new('https://twitter.com/username')
        .response
    end
    it 'without url protocol' do
      expect(OembedApi::Twitter).to receive(:new)
      OembedApi::Handler.new('twitter.com/username')
        .response
    end
  end
  it 'returns hash on successful request' do
    response = OembedApi::Handler
      .new('https://twitter.com/fahrenhei7lt/status/788802438467837952')
      .response
    expect(response).to be_a(Hash)
  end
end

