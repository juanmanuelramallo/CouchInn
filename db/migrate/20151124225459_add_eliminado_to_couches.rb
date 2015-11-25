class AddEliminadoToCouches < ActiveRecord::Migration
  def change
    add_column :couches, :eliminado, :boolean
  end
end
