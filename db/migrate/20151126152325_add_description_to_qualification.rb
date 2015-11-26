class AddDescriptionToQualification < ActiveRecord::Migration
  def change
    add_column :qualifications, :description, :string
  end
end
