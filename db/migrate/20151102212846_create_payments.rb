class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount
      t.integer :responseCode
      t.string :responseMessage

      t.timestamps null: false
    end
  end
end
