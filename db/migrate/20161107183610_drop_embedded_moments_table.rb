class DropEmbeddedMomentsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :embedded_moments do |t|
      t.json :body
      t.belongs_to :story, foreign_key: true, index: true
      t.timestamps
    end
  end
end
