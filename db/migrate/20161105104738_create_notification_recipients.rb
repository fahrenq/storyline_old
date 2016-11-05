class CreateNotificationRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_recipients do |t|
      t.belongs_to :user, index: true
      t.belongs_to :notification, index: true

      t.timestamps
    end
  end
end
