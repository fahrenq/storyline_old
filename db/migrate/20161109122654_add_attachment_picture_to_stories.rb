class AddAttachmentPictureToStories < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :stories, :picture
  end
end
