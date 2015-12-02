class ChangeNameToPaisInUsers < ActiveRecord::Migration
  def up
    change_column :users, :pais, :string
  end

  def down
    change_column :users, :pais, :integer
  end
end
