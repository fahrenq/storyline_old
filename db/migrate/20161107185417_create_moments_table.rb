class CreateMomentsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :moments do |t|
      t.text :body
      t.json :json_body
      t.belongs_to :story, foreign_key: true, index: true
      t.string :type

      t.timestamps
    end
  end
end
