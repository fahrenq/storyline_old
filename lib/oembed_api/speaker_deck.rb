module OembedApi
  class SpeakerDeck
    include Oembed::Client

    def endpoint_uri
      'http://speakerdeck.com/oembed.json'
    end
  end
end
