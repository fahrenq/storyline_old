require 'uri'
require 'oembedapi/twitter'
require 'oembedapi/youtube'

module OembedApi
  class Handler
    attr_accessor :url, :service_class

    SERVICES = {
      twitter: OembedApi::Twitter,
      youtube: OembedApi::Youtube
    }

    def initialize(url)
      @url = url
      smart_add_url_protocol
    end

    def response
      service_class.new.fetch(url)
    rescue NoMethodError
      nil
    end

    private

    def smart_add_url_protocol
      unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
        @url = "http://#{url}"
      end
    end

    def service_class
      @service_class ||= SERVICES[domain_name.to_sym]
    end

    def domain_name
      @domain_name ||= URI.parse(url).host.split('.').last(2)[0]
    end

  end
end
