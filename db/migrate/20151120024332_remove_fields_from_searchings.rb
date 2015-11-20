class RemoveFieldsFromSearchings < ActiveRecord::Migration
  def change
    remove_column :searchings, :descripcion_cont
    remove_column :searchings, :user_nombre
    remove_column :searchings, :user_puntos
    remove_column :searchings, :reservado
  end
end
