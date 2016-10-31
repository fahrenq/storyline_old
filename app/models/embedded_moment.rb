require 'oembedapi/handler'

class EmbeddedMoment < ApplicationRecord
  belongs_to :story

  validates :body, presence: true

  def fill(params)
    self.body = OembedApi::Handler.new(params[:url]).response
    if self.save
      self
    else
      false
    end
  end

end
