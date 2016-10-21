require 'rails_helper'

describe TwitterOEmbed  do
  it 'receives successful response' do
    response = subject.new.fetch('https://twitter.com/fahrenhei7lt/status/788802438467837952')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'reveives nil on invalid tweet adress' do
    response = subject.new.fetch('https://twitter.com/f1238')
    expect(response.nil?).to be_truthy
  end
end
