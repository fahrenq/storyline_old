module OembedAPI
  class Twitter
    include Oembed::Client

    def endpoint_uri
      'https://publish.twitter.com/oembed'
    end

    def fetch(url, options = {})
      super url, options.merge(omit_script: true)
    end
  end
end
