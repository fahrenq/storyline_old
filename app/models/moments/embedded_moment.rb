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

require 'oembedapi/handler'

class EmbeddedMoment < Moment
  validates :json_body, presence: true

  def fill(params)
    self.json_body = OembedApi::Handler.new(params[:url]).response
    if save
      self
    else
      false
    end
  end
end
