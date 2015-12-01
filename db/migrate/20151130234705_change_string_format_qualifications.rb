class ChangeStringFormatQualifications < ActiveRecord::Migration
  def change
  remove_column :qualifications, :percentage
  end
end
