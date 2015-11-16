class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :couches, :usuario_id, :user_id
  end
end
