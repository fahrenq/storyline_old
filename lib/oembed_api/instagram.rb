module OembedAPI
  class Instagram
    include Oembed::Client

    def endpoint_uri
      'https://api.instagram.com/oembed'
    end
  end
end
