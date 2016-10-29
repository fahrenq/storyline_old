class Web::Moments::NativeMomentsController < Web::Moments::ApplicationController
  before_action :set_moment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def new
    @native_moment = NativeMoment.new(story: current_story)
    authorize @native_moment
  end

  def create
    @native_moment = current_story.native_moments.new(native_moment_params)
    authorize @native_moment
    if @native_moment.save
      redirect_to @native_moment
    else
      render :new
    end
  end

  def edit
    authorize @native_moment
  end

  def update
    authorize @native_moment
    if @native_moment.update(native_moment_params)
      redirect_to @native_moment
    else
      render :edit
    end
  end

  def destroy
    authorize @native_moment
    @native_moment.destroy
    redirect_to @native_moment.story
  end

  private

  def set_moment
    @native_moment = NativeMoment.find(params[:id])
  end

  def native_moment_params
    params.require(:native_moment)
          .permit(:name, :body)
        # .merge(story: current_story)
  end
end
