class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :genero, :integer, default: 0, index: true
  end
end
