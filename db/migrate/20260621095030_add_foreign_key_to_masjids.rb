class AddForeignKeyToMasjids < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :masjids, :users, column: :imam_id
    add_index :masjids, :imam_id
  end
end