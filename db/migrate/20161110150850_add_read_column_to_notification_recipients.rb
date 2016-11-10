class AddReadColumnToNotificationRecipients < ActiveRecord::Migration[5.0]
  def change
    add_column :notification_recipients, :read, :boolean, default: false
  end
end
