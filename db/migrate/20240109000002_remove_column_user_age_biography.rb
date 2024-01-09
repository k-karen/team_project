class RemoveColumnUserAgeBiography < ActiveRecord::Migration[7.0]
  def change
    # usersテーブルからageとbiographyを削除する
    remove_column :users, :age, :integer
    remove_column :users, :biography, :text
  end
end

