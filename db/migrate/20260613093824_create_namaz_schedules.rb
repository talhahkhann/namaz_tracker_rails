class CreateNamazSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :namaz_schedules do |t|
      t.references :masjid, null: false, foreign_key: true
      t.time :fajr
      t.time :dhuhr
      t.time :asr
      t.time :maghrib
      t.time :isha

      t.timestamps
    end
  end
end
