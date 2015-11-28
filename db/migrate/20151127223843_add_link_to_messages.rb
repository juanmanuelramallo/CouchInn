class AddLinkToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :objectid
    add_column :messages, :link, :string
  end
end
