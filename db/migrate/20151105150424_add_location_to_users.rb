class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pais, :integer
    add_column :users, :ciudad, :string
  end
end
