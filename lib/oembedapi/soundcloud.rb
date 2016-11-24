module OembedApi
  class Soundcloud
    include Oembed::Client

    def endpoint_uri
      'http://soundcloud.com/oembed'
    end

    def fetch(url, options = {})
      super url, options.merge(format: 'json')
    end
  end
end
