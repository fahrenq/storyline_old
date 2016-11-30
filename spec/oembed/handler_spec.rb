require 'rails_helper'

describe OembedAPI::Handler do
  context 'choose api to call' do
    it 'with url protocol' do
      expect(OembedAPI::Twitter).to receive(:new)
      OembedAPI::Handler.new('https://twitter.com/username')
                        .response
    end
    it 'without url protocol' do
      expect(OembedAPI::Twitter).to receive(:new)
      OembedAPI::Handler.new('twitter.com/username')
                        .response
    end
  end
  it 'returns hash on successful request', :vcr do
    response = OembedAPI::Handler
               .new('https://twitter.com/fahrenhei7lt/status/788802438467837952')
               .response
    expect(response).to be_a(Hash)
  end
end
