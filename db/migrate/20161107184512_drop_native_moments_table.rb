class DropNativeMomentsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :native_moments do |t|
      t.text :body
      t.belongs_to :story, foreign_key: true, index: true
      t.timestamps
    end
  end
end
