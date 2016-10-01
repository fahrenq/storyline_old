class Web::Moments::ApplicationController < Web::ApplicationController
  helper_method :current_story

  def current_story
    @current_story ||= Story.find(params[:story_id])
  end
end
