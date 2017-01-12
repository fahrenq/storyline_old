# == Schema Information
#
# Table name: moments
#
#  id                   :integer          not null, primary key
#  body                 :text
#  json_body            :json
#  story_id             :integer
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class EmbeddedMoment < Moment
  validates :json_body, presence: true

  # alias_attribute :body, :json_body

  def url=(url); end

  #def fill(params)
    #self.json_body = OembedAPI::Handler.new(params[:url]).response
    #self.happened_at = DateTime.parse(params[:happened_at]).in_time_zone(Time.zone)
    #if save
      #self
    #else
      #false
    #end
  #end

  def provider
    # provider is service name like 'twitter', 'youtube', etc.
    json_body['provider_name'].downcase
  end
end
