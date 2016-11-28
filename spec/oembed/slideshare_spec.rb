require 'rails_helper'

describe OembedApi::Slideshare, :vcr do
  it 'receives successful response' do
    response = subject.fetch('http://www.slideshare.net/inarocket/learn-bem-css-naming-convention/2-Learn_frontend_development_at_rocket')
    expect(response.is_a?(Hash)).to be_truthy
  end
  it 'receives nil on invalid adress' do
    response = subject.fetch('http://www.sledshr.et/ifrontend_development_at_ot')
    expect(response.nil?).to be_truthy
  end
end
