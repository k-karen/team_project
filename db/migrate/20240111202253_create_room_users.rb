class CreateRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :room_users do |t|
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end

    # roomとuserの組み合わせをユニークに
    add_index :room_users, :room_id
    add_index :room_users, :user_id
    add_index :room_users, [:room_id, :user_id], unique: true
  end
end
