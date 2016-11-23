require 'rails_helper'
require 'oembedapi/instagram'

describe OembedApi::Instagram, :vcr do
  it 'receives successful response' do
    response = subject.fetch('https://www.instagram.com/p/BMCEzS6hd4P/?taken-by=heroku')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'receives nil on invalid adress' do
    response = subject.fetch('https://www.instagramcm.sr/pBMCEzS6hd4/?ake-y=heroku')
    expect(response.nil?).to be_truthy
  end
end
