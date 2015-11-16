class AddCamposToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nombre , :string
    add_column :users, :apellido, :string
    add_column :users, :fecnac, :date
    add_column :users, :telf, :string
    add_column :users, :rol, :integer
  end
end
