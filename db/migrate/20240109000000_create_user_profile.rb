class CreateUserProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.integer :age
      t.text :biography

      t.timestamps
    end
  end
end

