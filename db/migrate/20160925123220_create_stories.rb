class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, foreign_key: true, index: true
    end
  end
end
