module OembedApi
  class Vimeo
    include Oembed::Client

    def endpoint_uri
      'https://vimeo.com/api/oembed.json'
    end
  end
end
