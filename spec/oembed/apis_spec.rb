require 'rails_helper'

describe 'OembedApi::Class' do

  CLASSES = {
    Codepen: 'http://codepen.io/mudrenok/pen/aBWbgM',
    DeviantArt: 'http://www.deviantart.com/art/Reading-time-645328427',
    Instagram: 'https://www.instagram.com/p/BMCEzS6hd4P/?taken-by=heroku',
    Slideshare: 'http://www.slideshare.net/inarocket/learn-bem-css-naming-convention/2-Learn_frontend_development_at_rocket',
    Soundcloud: 'https://soundcloud.com/21savage/x-feat-future',
    Speakerdeck: 'https://speakerdeck.com/akmur/atom-resistance-is-futile',
    Twitter: 'https://twitter.com/fahrenhei7lt/status/788802438467837952',
    Vimeo: 'https://vimeo.com/169850570',
    Youtube: 'https://www.youtube.com/watch?v=mezO-nr7Ah4'
  }

  CLASSES.each do |k, v|
    describe "OembedApi::#{k}".constantize, :vcr do
      it 'receives successful response' do
        response = subject.fetch(v)
        expect(response.is_a?(Hash)).to be_truthy
      end
      it 'receives nil on invalid url' do
        response = subject.fetch('https://www.err.ror/badlink')
        expect(response.nil?).to be_truthy
      end
    end
  end
end
