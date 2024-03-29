class Web::Moments::NativeMomentsController < Web::Moments::ApplicationController
  before_action :set_moment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def new
    @native_moment = NativeMoment.new(story: current_story)
    authorize @native_moment
  end

  def create
    @native_moment = NativeMoment.new(native_moment_params)
    authorize @native_moment
    if @native_moment.save
      Notification.create_for_new_moment(@native_moment)
      redirect_to native_moment_path(@native_moment.id)
    else
      render :new
    end
  end

  def edit
    authorize @native_moment
  end

  def update
    authorize @native_moment
    if @native_moment.update(native_moment_params_shallow)
      redirect_to @native_moment
    else
      render :edit
    end
  end

  def destroy
    authorize @native_moment
    @native_moment.destroy
    redirect_to story_path(@native_moment.story)
  end

  private

  def set_moment
    @native_moment = NativeMoment.find(params[:id])
  end

  def native_moment_params
    params.require(:native_moment)
          .permit(:body, :picture, :happened_at)
          .merge(story: current_story)
  end

  def native_moment_params_shallow
    params.require(:native_moment)
          .permit(:body, :picture, :happened_at)
  end
end
