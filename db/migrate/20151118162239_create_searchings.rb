class CreateSearchings < ActiveRecord::Migration
  def change
    create_table :searchings do |t|
      t.integer :tipo
      t.string :ubicacion_cont
      t.integer :capacidad
      t.string :descripcion_cont
      t.string :user_nombre
      t.integer :user_puntos
      t.boolean :reservado
      t.date :free_from
      t.date :free_to
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
