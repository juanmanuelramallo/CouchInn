class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.integer :couch_id
      t.integer :user_id
      t.string :percentage

      t.timestamps null: false
    end
  end
end
