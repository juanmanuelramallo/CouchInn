class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.integer :couch_id
      t.string :nombre

      t.timestamps null: false
    end
  end
end
