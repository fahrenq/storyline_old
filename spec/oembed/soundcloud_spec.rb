require 'rails_helper'

describe OembedApi::Soundcloud, :vcr do
  it 'receives successful response' do
    response = subject.fetch('https://soundcloud.com/21savage/x-feat-future')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'receives nil on invalid adress' do
    response = subject.fetch('https://oundc.loudom1savageeat-future')
    expect(response.nil?).to be_truthy
  end
end
