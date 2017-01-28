class AddStoryReferenceToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :story, foreign_key: true
  end
end
