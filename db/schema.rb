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

ActiveRecord::Schema.define(version: 20160326012622) do

  create_table "clientes", force: :cascade do |t|
    t.text     "nombre"
    t.text     "direccion"
    t.text     "telefono"
    t.float    "deuda"
    t.text     "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compras", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "proveedor_id"
    t.float    "total"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "item_compras", force: :cascade do |t|
    t.integer  "compra_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio_unitario"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "item_compras", ["compra_id"], name: "index_item_compras_on_compra_id"
  add_index "item_compras", ["producto_id"], name: "index_item_compras_on_producto_id"

  create_table "item_venta", force: :cascade do |t|
    t.integer  "venta_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.float    "precio_unitario"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "item_venta", ["producto_id"], name: "index_item_venta_on_producto_id"
  add_index "item_venta", ["venta_id"], name: "index_item_venta_on_venta_id"

  create_table "producto_provisorios", force: :cascade do |t|
    t.integer  "id_producto"
    t.integer  "cantidad"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "productos", force: :cascade do |t|
    t.text     "nombre"
    t.text     "descripcion"
    t.integer  "cantidad"
    t.float    "precioCompra"
    t.float    "precioVenta"
    t.text     "estado"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "proveedors", force: :cascade do |t|
    t.text     "nombre"
    t.text     "direccion"
    t.text     "telefono"
    t.float    "deuda"
    t.text     "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "role"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venta", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "cliente_id"
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
