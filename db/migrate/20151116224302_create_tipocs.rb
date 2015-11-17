class CreateTipocs < ActiveRecord::Migration
  def change
    create_table :tipocs do |t|
      t.string :tipo

      t.timestamps null: false
    end
  end
end
