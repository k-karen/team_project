class MigrateProfile < ActiveRecord::Migration[7.0]
  def change
    User.all.each do |user|
      UserProfile.create!(user_id: user.id, age: user.age, biography: user.biography)
    end
  end
end

