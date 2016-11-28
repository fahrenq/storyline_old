module OembedApi
  class Slideshare
    include Oembed::Client

    def endpoint_uri
      'http://www.slideshare.net/api/oembed/2'
    end

    def fetch(url, options = {})
      super url, options.merge(format: 'json')
    end
  end
end
