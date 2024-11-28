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

ActiveRecord::Schema[7.1].define(version: 2024_11_28_112940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ability_scores", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "adventuring_gears", force: :cascade do |t|
    t.string "name"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.string "gear_category"
    t.text "description"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_adventuring_gears_on_equipment_categories_id"
  end

  create_table "alignments", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "armors", force: :cascade do |t|
    t.string "name"
    t.integer "armor_class"
    t.string "armor_class_bonus"
    t.string "cost_unity"
    t.string "armor_category"
    t.integer "cost_quantity"
    t.integer "weight"
    t.boolean "stealth_disadvantage"
    t.integer "strength_requirement"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_armors_on_equipment_categories_id"
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

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "damage_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.string "equipmentable_type", null: false
    t.bigint "equipmentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipmentable_type", "equipmentable_id"], name: "index_equipment_on_equipmentable"
  end

  create_table "equipment_categories", force: :cascade do |t|
    t.string "name"
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

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "language_type"
    t.string "typical_speakers"
    t.string "script"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_schools", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magical_items", force: :cascade do |t|
    t.string "name"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.text "description"
    t.string "rarity"
    t.boolean "variant"
    t.string "variants"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_magical_items_on_equipment_categories_id"
  end

  create_table "mounts", force: :cascade do |t|
    t.string "name"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.integer "speed"
    t.string "speed_unity"
    t.string "carry_capacity"
    t.text "description"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_mounts_on_equipment_categories_id"
  end

  create_table "rule_scopes", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "rule_scope_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rule_scope_id"], name: "index_rules_on_rule_scope_id"
  end

  create_table "shields", force: :cascade do |t|
    t.string "name"
    t.integer "armor_class"
    t.string "armor_class_bonus"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.text "description"
    t.boolean "stealth_disadvantage"
    t.integer "strength_requirement"
    t.string "rarity"
    t.boolean "variant"
    t.string "variants"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_shields_on_equipment_categories_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "ability_score_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_score_id"], name: "index_skills_on_ability_score_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.string "tool_category"
    t.text "description"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_tools_on_equipment_categories_id"
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

  create_table "weapon_damage_types", force: :cascade do |t|
    t.bigint "weapon_id"
    t.bigint "damage_type_id"
    t.string "damage_instance"
    t.index ["damage_type_id"], name: "index_weapon_damage_types_on_damage_type_id"
    t.index ["weapon_id"], name: "index_weapon_damage_types_on_weapon_id"
  end

  create_table "weapon_properties", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapon_property_weapons", force: :cascade do |t|
    t.bigint "weapon_property_id"
    t.bigint "weapon_id"
    t.index ["weapon_id"], name: "index_weapon_property_weapons_on_weapon_id"
    t.index ["weapon_property_id"], name: "index_weapon_property_weapons_on_weapon_property_id"
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.string "weapon_category"
    t.string "weapon_range"
    t.string "category_range"
    t.string "damage_dice"
    t.string "two_hand_damage_dice"
    t.integer "normal_range"
    t.integer "long_range"
    t.string "cost_unity"
    t.integer "cost_quantity"
    t.integer "weight"
    t.string "special"
    t.integer "throw_range_normal"
    t.integer "throw_range_long"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_weapons_on_equipment_categories_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adventuring_gears", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "armors", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "magical_items", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "mounts", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "rules", "rule_scopes"
  add_foreign_key "shields", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "skills", "ability_scores"
  add_foreign_key "tools", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "weapons", "equipment_categories", column: "equipment_categories_id"
end
