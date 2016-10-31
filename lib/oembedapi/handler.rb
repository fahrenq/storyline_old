require 'uri'
require 'oembedapi/twitter'
require 'oembedapi/youtube'

module OembedApi
  class Handler
    attr_accessor :url, :service_class

    SERVICES = {
      twitter: OembedApi::Twitter,
      youtube: OembedApi::Youtube
    }.freeze

    def initialize(url)
      @url = url
      # adds 'http://' if http or https protocol not stated
      smart_add_url_protocol
    end

    def response
      service_class.new.fetch(url)
    rescue NoMethodError
      nil
    end

    private

    def smart_add_url_protocol
      @url = "http://#{url}" unless url[%r{\Ahttps?:\/\/}]
    end

    def service_class
      @service_class ||= SERVICES[domain_name.to_sym]
    end

    def domain_name
      # gets domain name part of url,
      # ex: http://mobile.twitter.com/userman/userwoman returns just twutter
      @domain_name ||= URI.parse(url).host.split('.').last(2)[0]
    end
  end
end
