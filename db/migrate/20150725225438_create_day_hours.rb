class CreateDayHours < ActiveRecord::Migration
  def change
    create_table :day_hours do |t|
      t.string :day
      t.string :opening_time
      t.string :closing_time
      t.references :venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
