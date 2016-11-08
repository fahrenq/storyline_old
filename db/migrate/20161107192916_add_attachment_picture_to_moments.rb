class AddAttachmentPictureToMoments < ActiveRecord::Migration
  def self.up
    change_table :moments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :moments, :picture
  end
end
