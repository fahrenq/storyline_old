class Web::NotificationsController < Web::ApplicationController
  before_action :authenticate_user!
  after_action :read_notifications

  def index
    @notifications = Notification.for_user(current_user)
  end

  private

  def read_notifications
    unless @notifications.all? { |n| n.read_by?(current_user) }
      ReadNotifications.new(@notifications, current_user).call
    end
  end
end
