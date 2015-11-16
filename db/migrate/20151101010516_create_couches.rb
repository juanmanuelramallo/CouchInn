class CreateCouches < ActiveRecord::Migration
  def change
    create_table :couches do |t|
      t.integer :tipo
      t.string :ubicacion
      t.integer :capacidad
      t.string :descripcion
      t.integer :usuario_id
      t.boolean :reservado

      t.timestamps null: false
    end
  end
end
