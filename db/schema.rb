# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151118162239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "couches", force: :cascade do |t|
    t.integer  "tipo"
    t.string   "ubicacion"
    t.integer  "capacidad"
    t.string   "descripcion"
    t.integer  "user_id"
    t.boolean  "reservado"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fotos", force: :cascade do |t|
    t.integer  "couch_id"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.float    "amount"
    t.integer  "responseCode"
    t.string   "responseMessage"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "couch_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searchings", force: :cascade do |t|
    t.integer  "tipo"
    t.string   "ubicacion_cont"
    t.integer  "capacidad"
    t.string   "descripcion_cont"
    t.string   "user_nombre"
    t.integer  "user_puntos"
    t.boolean  "reservado"
    t.date     "free_from"
    t.date     "free_to"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "tipocs", force: :cascade do |t|
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fecnac"
    t.string   "telf"
    t.integer  "rol"
    t.integer  "pais"
    t.string   "ciudad"
    t.integer  "genero",                 default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
