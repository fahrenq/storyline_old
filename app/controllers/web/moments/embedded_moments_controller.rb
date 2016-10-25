class Web::Moments::EmbeddedMomentsController < Web::Moments::ApplicationController
  before_action :set_moment, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def new
    @embedded_moment = current_story.embedded_moments.new
    authorize @embedded_moment
  end

  def create
    authorize EmbeddedMoment.new(story: current_story)
    @embedded_moment = CreateEmbeddedMoment.new(current_story, embedded_moment_params).call
    if @embedded_moment
      redirect_to @embedded_moment
    else
      render :new
    end
  end

  def destroy
    authorize @embedded_moment
    @embedded_moment.destroy
    redirect_to @embedded_moment.story
  end

  private

  def set_moment
    @embedded_moment = EmbeddedMoment.find(params[:id])
  end

  def embedded_moment_params
    params.require(:embedded_moment)
          .permit(:url, :service)
        # .merge(story: current_story)
  end

end
