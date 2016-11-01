class AddAttachmentPictureToNativeMoments < ActiveRecord::Migration[5.0]
  def self.up
    change_table :native_moments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :native_moments, :picture
  end
end
