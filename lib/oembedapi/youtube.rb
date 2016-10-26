module OembedApi
  class Youtube
    include Oembed::Client

    def endpoint_uri
      'https://www.youtube.com/oembed'
    end
  end
end
