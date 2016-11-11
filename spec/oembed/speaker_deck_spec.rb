require 'rails_helper'
require 'oembedapi/speaker_deck'

describe OembedApi::SpeakerDeck, :vcr do
  it 'receives successful response' do
    response = subject.fetch('https://speakerdeck.com/akmur/atom-resistance-is-futile')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'reveives nil on invalid tweet adress' do
    response = subject.fetch('https://speakerdeck.com/akmu322')
    expect(response.nil?).to be_truthy
  end
end
