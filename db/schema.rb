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

ActiveRecord::Schema.define(version: 2019_06_20_171314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assemblies", force: :cascade do |t|
    t.string "name"
    t.string "length"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_assemblies_on_category_id"
  end

  create_table "assembly_boms", force: :cascade do |t|
    t.integer "assembly_id"
    t.integer "part_id"
    t.integer "count"
    t.string "refdes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assembly_id"], name: "index_assembly_boms_on_assembly_id"
    t.index ["part_id"], name: "index_assembly_boms_on_part_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "table"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modulelogs", force: :cascade do |t|
    t.integer "serial"
    t.string "version"
    t.bigint "order_id"
    t.date "date"
    t.bigint "category_id"
    t.bigint "assembly_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assembly_id"], name: "index_modulelogs_on_assembly_id"
    t.index ["category_id"], name: "index_modulelogs_on_category_id"
    t.index ["order_id"], name: "index_modulelogs_on_order_id"
  end

  create_table "order_boms", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_boms_on_order_id"
    t.index ["product_id"], name: "index_order_boms_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "delivery"
    t.string "payment"
    t.string "warranty"
    t.integer "category_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_orders_on_category_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "description"
    t.string "mfg"
    t.string "mfg_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_parts_on_category_id"
  end

  create_table "product_boms", force: :cascade do |t|
    t.integer "assembly_id"
    t.integer "product_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assembly_id"], name: "index_product_boms_on_assembly_id"
    t.index ["product_id"], name: "index_product_boms_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "modulelogs", "assemblies"
  add_foreign_key "modulelogs", "categories"
  add_foreign_key "modulelogs", "orders"
end
