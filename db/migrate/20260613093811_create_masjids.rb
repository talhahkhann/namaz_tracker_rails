class CreateMasjids < ActiveRecord::Migration[8.1]
  def change
    create_table :masjids do |t|
      t.string :name
      t.string :address
      t.integer :imam_id

      t.timestamps
    end
  end
end
