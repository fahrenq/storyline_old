class CreateEmbeddedMoments < ActiveRecord::Migration[5.0]
  def change
    create_table :embedded_moments do |t|
      t.json :body
      t.belongs_to :story

      t.timestamps
    end
  end
end
