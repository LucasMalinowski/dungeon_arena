# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_26_101951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "klass"
    t.string "skin_color"
    t.string "hair_color"
    t.string "eye_color"
    t.string "gender"
    t.float "height"
    t.float "weight"
    t.integer "age"
    t.text "notes"
    t.text "backstory"
    t.string "alignment"
    t.string "allies"
    t.string "enemies"
    t.string "faith"
    t.string "lifestyle"
    t.string "personality"
    t.string "ideals"
    t.string "bonds"
    t.string "flaws"
    t.string "species"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "class_proficiencies", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.bigint "proficiency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_class_proficiencies_on_klass_id"
    t.index ["proficiency_id"], name: "index_class_proficiencies_on_proficiency_id"
  end

  create_table "class_saving_throws", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.bigint "saving_throw_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_class_saving_throws_on_klass_id"
    t.index ["saving_throw_id"], name: "index_class_saving_throws_on_saving_throw_id"
  end

  create_table "class_starting_equipments", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.bigint "equipment_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_class_starting_equipments_on_equipment_id"
    t.index ["klass_id"], name: "index_class_starting_equipments_on_klass_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.integer "hit_die", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proficiencies", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saving_throws", force: :cascade do |t|
    t.string "index", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "class_proficiencies", "klasses"
  add_foreign_key "class_proficiencies", "proficiencies"
  add_foreign_key "class_saving_throws", "klasses"
  add_foreign_key "class_saving_throws", "saving_throws"
  add_foreign_key "class_starting_equipments", "equipment"
  add_foreign_key "class_starting_equipments", "klasses"
end
