require 'rails_helper'
require 'oembedapi/codepen'

describe OembedApi::Codepen, :vcr do
  it 'receives successful response' do
    response = subject.fetch('http://codepen.io/mudrenok/pen/aBWbgM')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'receives nil on invalid adress' do
    response = subject.fetch('http://codepen.i/ureo/e/BWgM')
    expect(response.nil?).to be_truthy
  end
end
