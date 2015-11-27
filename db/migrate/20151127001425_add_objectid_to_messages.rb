class AddObjectidToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :objectid, :integer
  end
end
