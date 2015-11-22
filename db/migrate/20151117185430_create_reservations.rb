class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
    	t.integer  "user_id"
    	t.integer  "couch_id"
    	t.date     "start_date"
    	t.date     "end_date"
    	t.boolean   "confirmed"
      t.timestamps null: false
    end
  end
end
