module OembedAPI
  class Speakerdeck
    include Oembed::Client

    def endpoint_uri
      'http://speakerdeck.com/oembed.json'
    end
  end
end
