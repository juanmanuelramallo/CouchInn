class ChangeTypeInCouches < ActiveRecord::Migration
  def up
    change_column :couches, :tipo, :string
  end

  def down
    change_column :couches, :tipo, :integer
  end
end
