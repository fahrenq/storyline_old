class Web::Moments::EmbeddedMomentsController < Web::Moments::ApplicationController
  before_action :set_moment, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def new
    @embedded_moment = current_story.embedded_moments.new
    authorize @embedded_moment
  end

  def create
    @embedded_moment = EmbeddedMoment.new(embedded_moment_params)
    authorize @embedded_moment
    if @embedded_moment.save
      Notification.create_for_new_moment(@embedded_moment)
      redirect_to @embedded_moment
    else
      render :new
    end
  end

  def destroy
    authorize @embedded_moment
    @embedded_moment.destroy
    redirect_to story_path(@embedded_moment.story)
  end

  private

  def set_moment
    @embedded_moment = EmbeddedMoment.find(params[:id])
  end

  def embedded_moment_params
    params.require(:embedded_moment)
          .permit(:url, :happened_at)
          .merge(
            story: current_story,
            json_body: OembedAPI::Handler.new(params.dig(:embedded_moment, :url)).response
          )
  end
end
