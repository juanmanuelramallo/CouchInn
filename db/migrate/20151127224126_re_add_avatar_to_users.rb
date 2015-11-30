class ReAddAvatarToUsers < ActiveRecord::Migration
  def self.up
    remove_attachment :users, :avatar
    change_table :users do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :users, :avatar
  end
end
