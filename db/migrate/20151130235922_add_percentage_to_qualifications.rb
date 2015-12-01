class AddPercentageToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :percentage, :integer
  end
end
