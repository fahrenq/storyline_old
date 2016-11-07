# == Schema Information
#
# Table name: embedded_moments
#
#  id         :integer          not null, primary key
#  body       :json
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
