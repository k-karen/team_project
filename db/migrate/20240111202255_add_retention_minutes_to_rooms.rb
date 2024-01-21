class AddRetentionMinutesToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :retention_minutes, :integer
  end
end
