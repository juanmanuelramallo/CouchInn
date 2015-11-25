class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.integer :user_id
      t.integer :couch_id
      t.string :message
      t.boolean :active

      t.timestamps null: false
    end
  end
end
