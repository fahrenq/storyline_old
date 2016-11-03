require 'rails_helper'
require 'oembedapi/youtube'

describe OembedApi::Youtube, :vcr do
  it 'receives successful response' do
    response = subject.fetch('https://www.youtube.com/watch?v=mezO-nr7Ah4')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'reveives nil on invalid tweet adress' do
    response = subject.fetch('https://www.youtube.com/watchmeplease')
    expect(response.nil?).to be_truthy
  end
end
