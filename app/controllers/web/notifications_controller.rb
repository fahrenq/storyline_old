class Web::NotificationsController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
    ReadNotifications.new(@notifications, current_user).call
  end
end
