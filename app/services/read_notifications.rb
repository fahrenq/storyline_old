class ReadNotifications
  attr_reader :notifications, :user

  def initialize(notifications, user)
    @notifications = notifications
    @user = user
  end

  def call
    NotificationRecipient.where(notification: notifications, user: user).update_all(read: true)
  end
end
