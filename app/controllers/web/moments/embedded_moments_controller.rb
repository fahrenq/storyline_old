class Web::Moments::EmbeddedMomentsController < Web::Moments::ApplicationController
  before_action :set_moment, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def new
    @embedded_moment = current_story.embedded_moments.new
    authorize @embedded_moment
  end

  def create
    @embedded_moment = EmbeddedMoment.new(story: current_story)
    authorize @embedded_moment
    # EmbeddedMoment#fill receives params and fetch url from them,
    # then, it calls OembedApi::Handler. It determines what API class
    # to use, request JSON response from server and return it or nil.
    # #fill method writes it in EmbeddedMoment#body, and if it saves -
    # returns self, otherwise - returns false
    if @embedded_moment.fill(embedded_moment_params)
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
    params.require(:embedded_moment_attrs)
          .permit(:url)
  end
end
