require 'rails_helper'

describe OembedApi::Vimeo, :vcr do
  it 'receives successful response' do
    response = subject.fetch('https://vimeo.com/169850570')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'receives nil on invalid adress' do
    response = subject.fetch('https://vimo.om/169850570')
    expect(response.nil?).to be_truthy
  end
end
