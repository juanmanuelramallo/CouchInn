class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :couch_id
      t.string :start_date
      t.string :Date
      t.string :end_date
      t.string :Date
      t.string :confirmed
      t.string :Boolean

      t.timestamps null: false
    end
  end
end
