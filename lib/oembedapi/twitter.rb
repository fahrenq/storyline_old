module OembedApi
  class Twitter
    include Oembed::Client

    def endpoint_uri
      'https://publish.twitter.com/oembed'
    end
  end
end
