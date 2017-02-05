class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def home
    @subscribed_stories = current_user.sub_stories
  end

  def change_avatar
    @user.update(avatar_params)
    redirect_to edit_user_registration_path
  end

  def destroy_avatar
    @user.avatar.clear
    @user.save
    redirect_to edit_user_registration_path
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def avatar_params
    params.permit(:avatar)
  end
end
