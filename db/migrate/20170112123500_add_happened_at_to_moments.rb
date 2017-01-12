class AddHappenedAtToMoments < ActiveRecord::Migration[5.0]
  def change
    add_column :moments, :happened_at, :datetime
  end
end
