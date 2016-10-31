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

class EmbeddedMoment < ApplicationRecord
  belongs_to :story

  validates :body, presence: true

  def fill(params)
    self.body = OembedApi::Handler.new(params[:url]).response
    if save
      self
    else
      false
    end
  end
end
