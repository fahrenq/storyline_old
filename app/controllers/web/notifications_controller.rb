class Web::NotificationsController < Web::ApplicationController
  before_action :authenticate_user!
  after_action :read_notifications

  def index
    @notifications = current_user.notifications
  end

  private

  def read_notifications
    ReadNotifications.new(@notifications, current_user).call
  end
end
