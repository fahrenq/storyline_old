module OembedApi
  class DeviantArt
    include Oembed::Client

    def endpoint_uri
      'http://backend.deviantart.com/oembed'
    end
  end
end
