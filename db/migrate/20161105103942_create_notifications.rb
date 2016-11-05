class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :body
      t.integer :category, default: 0
      t.json :info

      t.timestamps
    end
  end
end
