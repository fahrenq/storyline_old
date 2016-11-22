class Web::UsersController < Web::ApplicationController
  before_action :set_user

  def change_avatar
    if @user.update(avatar_params)
      redirect_to edit_user_registration_path
    else
      render :edit
    end
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
    params.require(:user)
      .permit(:avatar)
  end
end
