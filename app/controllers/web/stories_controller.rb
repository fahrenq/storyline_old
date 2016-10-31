class Web::StoriesController < Web::ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_story, only: [:edit, :update, :destroy]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.includes(:native_moments, :embedded_moments)
                  .find(params[:id])
    @moments = (@story.native_moments + @story.embedded_moments)
               .sort_by(&:created_at).reverse!
  end

  def new
    @story = Story.new
  end

  def create
    # User data merges in story_params hash
    @story = Story.new(story_params)
    if @story.save
      redirect_to @story
    else
      render :new
    end
  end

  def edit
    authorize @story
  end

  def update
    authorize @story

    if @story.update(story_params)
      redirect_to @story
    else
      render :edit
    end
  end

  def destroy
    authorize @story

    @story.destroy
    redirect_to stories_path
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story)
          .permit(:title, :description, :user_id)
          .merge(user: current_user)
  end
end
