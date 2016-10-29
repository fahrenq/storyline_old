require 'oembedapi/twitter'
require 'oembedapi/youtube'

class CreateEmbeddedMoment
  attr_reader :url, :service, :api_class, :story

  def initialize(story, params)
    @url = params[:url]
    @service = params[:service]
    @story = story
  end

  def call
    embedded_moment = EmbeddedMoment.new(body: response, story: story)
    if embedded_moment.save
      embedded_moment
    else
      false
    end
  end

  private

  def api_class
    @api_class ||= case service
                   when 'twitter'
                     OembedApi::Twitter.new
                   when 'youtube'
                     OembedApi::Youtube.new
                   end
  end

  def response
    return nil if api_class.nil?
    @response ||= api_class.fetch(url)
  end
end
