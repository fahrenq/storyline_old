require 'rails_helper'
require 'oembedapi/deviant_art'

describe OembedApi::DeviantArt, :vcr do
  it 'receives successful response' do
    response = subject.fetch('http://www.deviantart.com/art/Reading-time-645328427')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'reveives nil on invalid tweet adress' do
    response = subject.fetch('http://www.deviantart.com/riie-645328427')
    expect(response.nil?).to be_truthy
  end
end
