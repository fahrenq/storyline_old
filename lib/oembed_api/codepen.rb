module OembedAPI
  class Codepen
    include Oembed::Client

    def endpoint_uri
      'http://codepen.io/api/oembed'
    end
  end
end
