require 'oembedapi/twitter'
class CreateEmbeddedMoment
  attr_reader :url, :service, :api_class, :story

  def initialize(params)
    @url = params[:url]
    @service = params[:service]
    @story = params[:story_id]
  end

  def call
    embedded_moment = EmbeddedMoment.new(body: response, story_id: story)
    if embedded_moment.save
      true
    else
      false
    end
  end

  private

  def api_class
    @api_class ||= case service
                   when 'twitter'
                     OembedApi::Twitter.new
                   end
  end

  def response
    return nil if api_class == nil
    @response ||= api_class.fetch(url)
  end
end
