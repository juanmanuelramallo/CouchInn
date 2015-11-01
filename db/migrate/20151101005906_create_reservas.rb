class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.integer :usuario_id
      t.integer :couch_id
      t.integer :estado

      t.timestamps null: false
    end
  end
end
