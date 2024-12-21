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

ActiveRecord::Schema[7.1].define(version: 2024_12_21_120220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ability_scores", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.text "description"
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
    t.integer "quantity"
    t.bigint "equipment_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_categories_id"], name: "index_adventuring_gears_on_equipment_categories_id"
  end

  create_table "alignments", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.text "description"
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

  create_table "background_bond_choice_options", force: :cascade do |t|
    t.bigint "background_bond_choice_id", null: false
    t.text "description"
    t.index ["background_bond_choice_id"], name: "idx_on_background_bond_choice_id_05d6c4c2c7"
  end

  create_table "background_bond_choices", force: :cascade do |t|
    t.bigint "background_id", null: false
    t.integer "choose"
    t.index ["background_id"], name: "index_background_bond_choices_on_background_id"
  end

  create_table "background_flaw_choice_options", force: :cascade do |t|
    t.bigint "background_flaw_choice_id", null: false
    t.text "description"
    t.index ["background_flaw_choice_id"], name: "idx_on_background_flaw_choice_id_108de687ea"
  end

  create_table "background_flaw_choices", force: :cascade do |t|
    t.bigint "background_id", null: false
    t.integer "choose"
    t.index ["background_id"], name: "index_background_flaw_choices_on_background_id"
  end

  create_table "background_ideal_choice_options", force: :cascade do |t|
    t.bigint "background_ideal_choice_id", null: false
    t.text "description"
    t.index ["background_ideal_choice_id"], name: "idx_on_background_ideal_choice_id_3064fbdf8a"
  end

  create_table "background_ideal_choices", force: :cascade do |t|
    t.bigint "background_id", null: false
    t.integer "choose"
    t.index ["background_id"], name: "index_background_ideal_choices_on_background_id"
  end

  create_table "background_ideal_option_alignments", force: :cascade do |t|
    t.bigint "background_ideal_choice_option_id", null: false
    t.bigint "alignment_id", null: false
    t.index ["alignment_id"], name: "index_background_ideal_option_alignments_on_alignment_id"
    t.index ["background_ideal_choice_option_id"], name: "idx_on_background_ideal_choice_option_id_729dc2930e"
  end

  create_table "background_personality_trait_choice_options", force: :cascade do |t|
    t.bigint "background_personality_trait_choice_id", null: false
    t.text "description"
    t.index ["background_personality_trait_choice_id"], name: "idx_on_background_personality_trait_choice_id_222f667a47"
  end

  create_table "background_personality_trait_choices", force: :cascade do |t|
    t.bigint "background_id", null: false
    t.integer "choose"
    t.index ["background_id"], name: "index_background_personality_trait_choices_on_background_id"
  end

  create_table "background_proficiencies", force: :cascade do |t|
    t.bigint "background_id", null: false
    t.bigint "proficiency_id", null: false
    t.index ["background_id"], name: "index_background_proficiencies_on_background_id"
    t.index ["proficiency_id"], name: "index_background_proficiencies_on_proficiency_id"
  end

  create_table "backgrounds", force: :cascade do |t|
    t.string "name"
    t.string "feature_name"
    t.text "feature_description"
    t.text "description"
    t.text "starting_equipment"
    t.text "tool_proficiencies"
    t.text "language_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_ability_scores", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_ability_scores_on_character_id"
  end

  create_table "character_classes", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "klass_id", null: false
    t.integer "level", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_classes_on_character_id"
    t.index ["klass_id"], name: "index_character_classes_on_klass_id"
  end

  create_table "character_inventories", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.integer "copper"
    t.integer "silver"
    t.integer "electrum"
    t.integer "gold"
    t.integer "platinum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_inventories_on_character_id"
  end

  create_table "character_notes", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "allies"
    t.string "organizations"
    t.string "enemies"
    t.string "faith"
    t.string "lifestyle"
    t.text "notes"
    t.text "backstory"
    t.text "other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_notes_on_character_id"
  end

  create_table "character_physical_characteristics", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.string "gender"
    t.integer "age"
    t.string "height"
    t.string "weight"
    t.string "eye_color"
    t.string "hair_color"
    t.string "skin_color"
    t.text "distinguishing_features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_physical_characteristics_on_character_id"
  end

  create_table "character_skills", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "skill_id", null: false
    t.integer "proficiency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_skills_on_character_id"
    t.index ["skill_id"], name: "index_character_skills_on_skill_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "exp"
    t.bigint "user_id", null: false
    t.bigint "background_id"
    t.bigint "alignment_id"
    t.bigint "race_id"
    t.bigint "subrace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alignment_id"], name: "index_characters_on_alignment_id"
    t.index ["background_id"], name: "index_characters_on_background_id"
    t.index ["race_id"], name: "index_characters_on_race_id"
    t.index ["subrace_id"], name: "index_characters_on_subrace_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "class_proficiencies", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "proficiency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_class_proficiencies_on_klass_id"
    t.index ["proficiency_id"], name: "index_class_proficiencies_on_proficiency_id"
  end

  create_table "class_saving_throws", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.bigint "saving_throw_id", null: false
    t.index ["klass_id"], name: "index_class_saving_throws_on_klass_id"
    t.index ["saving_throw_id"], name: "index_class_saving_throws_on_saving_throw_id"
  end

  create_table "class_spellcastings", force: :cascade do |t|
    t.integer "level", null: false
    t.bigint "ability_score_id", null: false
    t.bigint "klass_id", null: false
    t.index ["ability_score_id"], name: "index_class_spellcastings_on_ability_score_id"
    t.index ["klass_id"], name: "index_class_spellcastings_on_klass_id"
  end

  create_table "class_starting_equipment_choice_options", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "class_starting_equipment_choice_id", null: false
    t.bigint "equipment_id"
    t.bigint "equipment_category_id"
    t.index ["class_starting_equipment_choice_id"], name: "idx_on_class_starting_equipment_choice_id_6f644956ab"
    t.index ["equipment_category_id"], name: "idx_on_equipment_category_id_04964580bb"
    t.index ["equipment_id"], name: "index_class_starting_equipment_choice_options_on_equipment_id"
  end

  create_table "class_starting_equipment_choices", force: :cascade do |t|
    t.integer "choose"
    t.string "choice_type"
    t.string "description"
    t.bigint "klass_id", null: false
    t.index ["klass_id"], name: "index_class_starting_equipment_choices_on_klass_id"
  end

  create_table "class_starting_equipments", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "klass_id", null: false
    t.bigint "equipment_id", null: false
    t.bigint "equipment_category_id", null: false
    t.index ["equipment_category_id"], name: "index_class_starting_equipments_on_equipment_category_id"
    t.index ["equipment_id"], name: "index_class_starting_equipments_on_equipment_id"
    t.index ["klass_id"], name: "index_class_starting_equipments_on_klass_id"
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
    t.bigint "equipment_category_id"
    t.index ["equipment_category_id"], name: "index_equipment_on_equipment_category_id"
    t.index ["equipmentable_type", "equipmentable_id"], name: "index_equipment_on_equipmentable"
  end

  create_table "equipment_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertise_options", force: :cascade do |t|
    t.bigint "feature_id", null: false
    t.integer "choice_quantity"
    t.string "choice_type"
    t.string "options_list"
    t.index ["feature_id"], name: "index_expertise_options_on_feature_id"
  end

  create_table "feats", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "minimum_score"
    t.bigint "ability_score_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_score_id"], name: "index_feats_on_ability_score_id"
  end

  create_table "feature_prerequisites", force: :cascade do |t|
    t.string "prerequisite_type"
    t.string "prerequisite_name"
    t.string "prerequisite_value"
    t.bigint "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_feature_prerequisites_on_feature_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.text "description"
    t.integer "parent_id"
    t.bigint "klass_id", null: false
    t.bigint "subclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_features_on_klass_id"
    t.index ["subclass_id"], name: "index_features_on_subclass_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.bigint "character_inventory_id", null: false
    t.bigint "equipment_id", null: false
    t.integer "quantity"
    t.index ["character_inventory_id"], name: "index_inventory_items_on_character_inventory_id"
    t.index ["equipment_id"], name: "index_inventory_items_on_equipment_id"
  end

  create_table "invocations", force: :cascade do |t|
    t.bigint "feature_id", null: false
    t.string "name"
    t.index ["feature_id"], name: "index_invocations_on_feature_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hit_die"
    t.string "primary_ability"
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

  create_table "level_features", force: :cascade do |t|
    t.bigint "level_id", null: false
    t.bigint "feature_id", null: false
    t.index ["feature_id"], name: "index_level_features_on_feature_id"
    t.index ["level_id"], name: "index_level_features_on_level_id"
  end

  create_table "level_specifics", force: :cascade do |t|
    t.string "name"
    t.jsonb "data"
    t.bigint "level_id", null: false
    t.index ["level_id"], name: "index_level_specifics_on_level_id"
  end

  create_table "level_spellcastings", force: :cascade do |t|
    t.bigint "level_id", null: false
    t.integer "spell_slots_level_1"
    t.integer "spell_slots_level_2"
    t.integer "spell_slots_level_3"
    t.integer "spell_slots_level_4"
    t.integer "spell_slots_level_5"
    t.integer "spell_slots_level_6"
    t.integer "spell_slots_level_7"
    t.integer "spell_slots_level_8"
    t.integer "spell_slots_level_9"
    t.integer "spells_known"
    t.integer "cantrips_known"
    t.index ["level_id"], name: "index_level_spellcastings_on_level_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "level"
    t.integer "ability_score_bonus"
    t.integer "proficiency_bonus"
    t.bigint "klass_id", null: false
    t.bigint "subclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_levels_on_klass_id"
    t.index ["subclass_id"], name: "index_levels_on_subclass_id"
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

  create_table "monster_actions", force: :cascade do |t|
    t.bigint "monster_id", null: false
    t.string "name", null: false
    t.text "description"
    t.string "multiattack_type"
    t.jsonb "sub_actions", default: []
    t.integer "attack_bonus"
    t.jsonb "damage", default: []
    t.jsonb "dc", default: {}
    t.jsonb "usage", default: {}
    t.jsonb "options", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_id"], name: "index_monster_actions_on_monster_id"
  end

  create_table "monster_condition_immunities", force: :cascade do |t|
    t.string "condition_name"
    t.bigint "monster_id", null: false
    t.bigint "condition_id", null: false
    t.index ["condition_id"], name: "index_monster_condition_immunities_on_condition_id"
    t.index ["monster_id"], name: "index_monster_condition_immunities_on_monster_id"
  end

  create_table "monster_damage_immunities", force: :cascade do |t|
    t.string "damage_type_name"
    t.bigint "monster_id", null: false
    t.bigint "damage_type_id"
    t.index ["damage_type_id"], name: "index_monster_damage_immunities_on_damage_type_id"
    t.index ["monster_id"], name: "index_monster_damage_immunities_on_monster_id"
  end

  create_table "monster_damage_resistances", force: :cascade do |t|
    t.string "damage_type_name"
    t.bigint "monster_id", null: false
    t.bigint "damage_type_id"
    t.index ["damage_type_id"], name: "index_monster_damage_resistances_on_damage_type_id"
    t.index ["monster_id"], name: "index_monster_damage_resistances_on_monster_id"
  end

  create_table "monster_damage_vulnerabilities", force: :cascade do |t|
    t.string "damage_type_name"
    t.bigint "monster_id", null: false
    t.bigint "damage_type_id"
    t.index ["damage_type_id"], name: "index_monster_damage_vulnerabilities_on_damage_type_id"
    t.index ["monster_id"], name: "index_monster_damage_vulnerabilities_on_monster_id"
  end

  create_table "monster_jsons", force: :cascade do |t|
    t.string "name"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monster_legendary_actions", force: :cascade do |t|
    t.bigint "monster_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "attack_bonus"
    t.jsonb "damage", default: []
    t.jsonb "dc", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_id"], name: "index_monster_legendary_actions_on_monster_id"
  end

  create_table "monster_proficiencies", force: :cascade do |t|
    t.integer "value"
    t.bigint "monster_id"
    t.bigint "proficiency_id"
    t.index ["monster_id"], name: "index_monster_proficiencies_on_monster_id"
    t.index ["proficiency_id"], name: "index_monster_proficiencies_on_proficiency_id"
  end

  create_table "monster_reactions", force: :cascade do |t|
    t.bigint "monster_id", null: false
    t.string "name", null: false
    t.text "description"
    t.jsonb "dc", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_id"], name: "index_monster_reactions_on_monster_id"
  end

  create_table "monster_special_abilities", force: :cascade do |t|
    t.bigint "monster_id", null: false
    t.string "name", null: false
    t.text "description"
    t.jsonb "dc", default: {}
    t.jsonb "spellcasting", default: {}
    t.jsonb "usage", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_id"], name: "index_monster_special_abilities_on_monster_id"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "monster_subtype"
    t.string "size"
    t.string "monster_type"
    t.string "alignment"
    t.integer "hit_points"
    t.string "hit_dice"
    t.string "hit_points_roll"
    t.jsonb "speed"
    t.jsonb "armor_class", default: [], null: false
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.jsonb "senses"
    t.string "languages"
    t.integer "challenge_rating"
    t.integer "proficiency_bonus"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "multiclassing_prerequisites", force: :cascade do |t|
    t.bigint "multiclassing_id", null: false
    t.bigint "ability_score_id", null: false
    t.integer "minimum_score"
    t.index ["ability_score_id"], name: "index_multiclassing_prerequisites_on_ability_score_id"
    t.index ["multiclassing_id"], name: "index_multiclassing_prerequisites_on_multiclassing_id"
  end

  create_table "multiclassing_proficiencies", force: :cascade do |t|
    t.bigint "multiclassing_id", null: false
    t.bigint "proficiency_id", null: false
    t.index ["multiclassing_id"], name: "index_multiclassing_proficiencies_on_multiclassing_id"
    t.index ["proficiency_id"], name: "index_multiclassing_proficiencies_on_proficiency_id"
  end

  create_table "multiclassing_proficiency_choices", force: :cascade do |t|
    t.bigint "multiclassing_id", null: false
    t.bigint "proficiency_choice_id", null: false
    t.index ["multiclassing_id"], name: "index_multiclassing_proficiency_choices_on_multiclassing_id"
    t.index ["proficiency_choice_id"], name: "idx_on_proficiency_choice_id_ae60bf8bbe"
  end

  create_table "multiclassings", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.index ["klass_id"], name: "index_multiclassings_on_klass_id"
  end

  create_table "proficiencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proficiency_choice_options", force: :cascade do |t|
    t.bigint "proficiency_choice_id", null: false
    t.bigint "proficiency_id", null: false
    t.index ["proficiency_choice_id"], name: "index_proficiency_choice_options_on_proficiency_choice_id"
    t.index ["proficiency_id"], name: "index_proficiency_choice_options_on_proficiency_id"
  end

  create_table "proficiency_choices", force: :cascade do |t|
    t.bigint "klass_id", null: false
    t.string "description"
    t.integer "choose"
    t.string "proficiency_type"
    t.index ["klass_id"], name: "index_proficiency_choices_on_klass_id"
  end

  create_table "race_ability_bonus", force: :cascade do |t|
    t.bigint "race_id"
    t.bigint "ability_score_id"
    t.integer "bonus"
    t.index ["ability_score_id"], name: "index_race_ability_bonus_on_ability_score_id"
    t.index ["race_id"], name: "index_race_ability_bonus_on_race_id"
  end

  create_table "race_ability_bonus_choice_options", force: :cascade do |t|
    t.bigint "race_ability_bonus_choice_id"
    t.bigint "ability_score_id"
    t.index ["ability_score_id"], name: "index_race_ability_bonus_choice_options_on_ability_score_id"
    t.index ["race_ability_bonus_choice_id"], name: "idx_on_race_ability_bonus_choice_id_94433255a4"
  end

  create_table "race_ability_bonus_choices", force: :cascade do |t|
    t.bigint "race_id"
    t.integer "choose"
    t.index ["race_id"], name: "index_race_ability_bonus_choices_on_race_id"
  end

  create_table "race_language_choice_options", force: :cascade do |t|
    t.bigint "race_language_choice_id"
    t.bigint "language_id"
    t.index ["language_id"], name: "index_race_language_choice_options_on_language_id"
    t.index ["race_language_choice_id"], name: "index_race_language_choice_options_on_race_language_choice_id"
  end

  create_table "race_language_choices", force: :cascade do |t|
    t.bigint "race_id"
    t.integer "choose"
    t.index ["race_id"], name: "index_race_language_choices_on_race_id"
  end

  create_table "race_languages", force: :cascade do |t|
    t.bigint "race_id"
    t.bigint "language_id"
    t.index ["language_id"], name: "index_race_languages_on_language_id"
    t.index ["race_id"], name: "index_race_languages_on_race_id"
  end

  create_table "race_proficiencies", force: :cascade do |t|
    t.bigint "race_id"
    t.bigint "proficiency_id"
    t.index ["proficiency_id"], name: "index_race_proficiencies_on_proficiency_id"
    t.index ["race_id"], name: "index_race_proficiencies_on_race_id"
  end

  create_table "race_proficiency_choice_options", force: :cascade do |t|
    t.bigint "race_proficiency_choice_id"
    t.bigint "proficiency_id"
    t.index ["proficiency_id"], name: "index_race_proficiency_choice_options_on_proficiency_id"
    t.index ["race_proficiency_choice_id"], name: "idx_on_race_proficiency_choice_id_a3a54605f5"
  end

  create_table "race_proficiency_choices", force: :cascade do |t|
    t.bigint "race_id"
    t.string "description"
    t.integer "choose"
    t.index ["race_id"], name: "index_race_proficiency_choices_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "speed"
    t.text "alignment_description"
    t.text "age_description"
    t.string "size"
    t.text "size_description"
    t.text "language_description"
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

  create_table "saving_throws", force: :cascade do |t|
    t.bigint "ability_score_id", null: false
    t.index ["ability_score_id"], name: "index_saving_throws_on_ability_score_id"
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

  create_table "spell_classes", force: :cascade do |t|
    t.bigint "spell_id"
    t.bigint "klass_id"
    t.index ["klass_id"], name: "index_spell_classes_on_klass_id"
    t.index ["spell_id"], name: "index_spell_classes_on_spell_id"
  end

  create_table "spell_subclasses", force: :cascade do |t|
    t.bigint "spell_id"
    t.bigint "subclass_id"
    t.index ["spell_id"], name: "index_spell_subclasses_on_spell_id"
    t.index ["subclass_id"], name: "index_spell_subclasses_on_subclass_id"
  end

  create_table "spellcasting_infos", force: :cascade do |t|
    t.bigint "class_spellcasting_id", null: false
    t.string "name", null: false
    t.jsonb "description", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_spellcasting_id"], name: "index_spellcasting_infos_on_class_spellcasting_id"
  end

  create_table "spells", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "range"
    t.string "components"
    t.string "material"
    t.boolean "ritual"
    t.string "duration"
    t.boolean "concentration"
    t.string "casting_time"
    t.string "level"
    t.string "higher_level"
    t.string "attack_type"
    t.jsonb "damage_at_slot_level"
    t.jsonb "damage_at_character_level"
    t.jsonb "heal_at_slot_level"
    t.string "area_of_effect_type"
    t.string "area_of_effect_size"
    t.string "dc_type"
    t.string "dc_success"
    t.bigint "magic_school_id"
    t.bigint "damage_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "cantrip", default: false
    t.index ["damage_type_id"], name: "index_spells_on_damage_type_id"
    t.index ["magic_school_id"], name: "index_spells_on_magic_school_id"
  end

  create_table "subclass_spell_prerequisites", force: :cascade do |t|
    t.string "prerequisite_type"
    t.string "name"
    t.bigint "subclass_id", null: false
    t.bigint "spell_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spell_id"], name: "index_subclass_spell_prerequisites_on_spell_id"
    t.index ["subclass_id"], name: "index_subclass_spell_prerequisites_on_subclass_id"
  end

  create_table "subclasses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "subclass_flavor"
    t.bigint "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_subclasses_on_klass_id"
  end

  create_table "subfeature_options", force: :cascade do |t|
    t.bigint "feature_id", null: false
    t.integer "choice_quantity"
    t.string "choice_type"
    t.string "options_list"
    t.index ["feature_id"], name: "index_subfeature_options_on_feature_id"
  end

  create_table "subrace_ability_bonus", force: :cascade do |t|
    t.bigint "subrace_id"
    t.bigint "ability_score_id"
    t.integer "bonus"
    t.index ["ability_score_id"], name: "index_subrace_ability_bonus_on_ability_score_id"
    t.index ["subrace_id"], name: "index_subrace_ability_bonus_on_subrace_id"
  end

  create_table "subrace_language_choice_options", force: :cascade do |t|
    t.bigint "subrace_language_choice_id"
    t.bigint "language_id"
    t.index ["language_id"], name: "index_subrace_language_choice_options_on_language_id"
    t.index ["subrace_language_choice_id"], name: "idx_on_subrace_language_choice_id_b1654744a4"
  end

  create_table "subrace_language_choices", force: :cascade do |t|
    t.bigint "subrace_id"
    t.integer "choose"
    t.index ["subrace_id"], name: "index_subrace_language_choices_on_subrace_id"
  end

  create_table "subrace_proficiencies", force: :cascade do |t|
    t.bigint "subrace_id"
    t.bigint "proficiency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proficiency_id"], name: "index_subrace_proficiencies_on_proficiency_id"
    t.index ["subrace_id"], name: "index_subrace_proficiencies_on_subrace_id"
  end

  create_table "subraces", force: :cascade do |t|
    t.string "name"
    t.bigint "race_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["race_id"], name: "index_subraces_on_race_id"
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

  create_table "trait_languages_choice_options", force: :cascade do |t|
    t.bigint "trait_languages_choice_id", null: false
    t.bigint "language_id", null: false
    t.index ["language_id"], name: "index_trait_languages_choice_options_on_language_id"
    t.index ["trait_languages_choice_id"], name: "idx_on_trait_languages_choice_id_4dd9692185"
  end

  create_table "trait_languages_choices", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.integer "choose"
    t.index ["trait_id"], name: "index_trait_languages_choices_on_trait_id"
  end

  create_table "trait_proficiencies", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.bigint "proficiency_id", null: false
    t.index ["proficiency_id"], name: "index_trait_proficiencies_on_proficiency_id"
    t.index ["trait_id"], name: "index_trait_proficiencies_on_trait_id"
  end

  create_table "trait_proficiency_choice_options", force: :cascade do |t|
    t.bigint "trait_proficiency_choice_id", null: false
    t.bigint "proficiency_id", null: false
    t.index ["proficiency_id"], name: "index_trait_proficiency_choice_options_on_proficiency_id"
    t.index ["trait_proficiency_choice_id"], name: "idx_on_trait_proficiency_choice_id_6147888527"
  end

  create_table "trait_proficiency_choices", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.integer "choose"
    t.index ["trait_id"], name: "index_trait_proficiency_choices_on_trait_id"
  end

  create_table "trait_races", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.bigint "race_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_trait_races_on_race_id"
    t.index ["trait_id"], name: "index_trait_races_on_trait_id"
  end

  create_table "trait_specific_damage_breaths", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.bigint "damage_type_id", null: false
    t.bigint "saving_throw_id", null: false
    t.string "name"
    t.text "description"
    t.integer "area_size"
    t.string "area_type"
    t.string "usage_type"
    t.integer "usage_times"
    t.string "dc_success_type"
    t.jsonb "damage_at_character_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_type_id"], name: "index_trait_specific_damage_breaths_on_damage_type_id"
    t.index ["saving_throw_id"], name: "index_trait_specific_damage_breaths_on_saving_throw_id"
    t.index ["trait_id"], name: "index_trait_specific_damage_breaths_on_trait_id"
  end

  create_table "trait_specific_spell_options", force: :cascade do |t|
    t.bigint "trait_specific_spell_id", null: false
    t.bigint "spell_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spell_id"], name: "index_trait_specific_spell_options_on_spell_id"
    t.index ["trait_specific_spell_id"], name: "index_trait_specific_spell_options_on_trait_specific_spell_id"
  end

  create_table "trait_specific_spells", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.integer "choose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trait_id"], name: "index_trait_specific_spells_on_trait_id"
  end

  create_table "trait_specific_subtrait_options", force: :cascade do |t|
    t.bigint "trait_specific_subtrait_id", null: false
    t.bigint "trait_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trait_id"], name: "index_trait_specific_subtrait_options_on_trait_id"
    t.index ["trait_specific_subtrait_id"], name: "idx_on_trait_specific_subtrait_id_da4f92dc0b"
  end

  create_table "trait_specific_subtraits", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.integer "choose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trait_id"], name: "index_trait_specific_subtraits_on_trait_id"
  end

  create_table "trait_subraces", force: :cascade do |t|
    t.bigint "trait_id", null: false
    t.bigint "subrace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subrace_id"], name: "index_trait_subraces_on_subrace_id"
    t.index ["trait_id"], name: "index_trait_subraces_on_trait_id"
  end

  create_table "traits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "parent_id"
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
  add_foreign_key "background_bond_choice_options", "background_bond_choices"
  add_foreign_key "background_bond_choices", "backgrounds"
  add_foreign_key "background_flaw_choice_options", "background_flaw_choices"
  add_foreign_key "background_flaw_choices", "backgrounds"
  add_foreign_key "background_ideal_choice_options", "background_ideal_choices"
  add_foreign_key "background_ideal_choices", "backgrounds"
  add_foreign_key "background_ideal_option_alignments", "alignments"
  add_foreign_key "background_ideal_option_alignments", "background_ideal_choice_options"
  add_foreign_key "background_personality_trait_choice_options", "background_personality_trait_choices"
  add_foreign_key "background_personality_trait_choices", "backgrounds"
  add_foreign_key "background_proficiencies", "backgrounds"
  add_foreign_key "background_proficiencies", "proficiencies"
  add_foreign_key "character_ability_scores", "characters"
  add_foreign_key "character_classes", "characters"
  add_foreign_key "character_classes", "klasses"
  add_foreign_key "character_inventories", "characters"
  add_foreign_key "character_notes", "characters"
  add_foreign_key "character_physical_characteristics", "characters"
  add_foreign_key "character_skills", "characters"
  add_foreign_key "character_skills", "skills"
  add_foreign_key "characters", "alignments"
  add_foreign_key "characters", "backgrounds"
  add_foreign_key "characters", "races"
  add_foreign_key "characters", "subraces"
  add_foreign_key "characters", "users"
  add_foreign_key "class_proficiencies", "klasses"
  add_foreign_key "class_proficiencies", "proficiencies"
  add_foreign_key "class_saving_throws", "klasses"
  add_foreign_key "class_saving_throws", "saving_throws"
  add_foreign_key "class_spellcastings", "ability_scores"
  add_foreign_key "class_spellcastings", "klasses"
  add_foreign_key "class_starting_equipment_choice_options", "class_starting_equipment_choices"
  add_foreign_key "class_starting_equipment_choice_options", "equipment"
  add_foreign_key "class_starting_equipment_choice_options", "equipment_categories"
  add_foreign_key "class_starting_equipment_choices", "klasses"
  add_foreign_key "class_starting_equipments", "equipment"
  add_foreign_key "class_starting_equipments", "equipment_categories"
  add_foreign_key "class_starting_equipments", "klasses"
  add_foreign_key "equipment", "equipment_categories"
  add_foreign_key "expertise_options", "features"
  add_foreign_key "feats", "ability_scores"
  add_foreign_key "feature_prerequisites", "features"
  add_foreign_key "features", "klasses"
  add_foreign_key "features", "subclasses"
  add_foreign_key "inventory_items", "character_inventories"
  add_foreign_key "inventory_items", "equipment"
  add_foreign_key "invocations", "features"
  add_foreign_key "level_features", "features"
  add_foreign_key "level_features", "levels"
  add_foreign_key "level_specifics", "levels"
  add_foreign_key "level_spellcastings", "levels"
  add_foreign_key "levels", "klasses"
  add_foreign_key "levels", "subclasses"
  add_foreign_key "magical_items", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "monster_actions", "monsters"
  add_foreign_key "monster_condition_immunities", "conditions"
  add_foreign_key "monster_condition_immunities", "monsters"
  add_foreign_key "monster_damage_immunities", "damage_types"
  add_foreign_key "monster_damage_immunities", "monsters"
  add_foreign_key "monster_damage_resistances", "damage_types"
  add_foreign_key "monster_damage_resistances", "monsters"
  add_foreign_key "monster_damage_vulnerabilities", "damage_types"
  add_foreign_key "monster_damage_vulnerabilities", "monsters"
  add_foreign_key "monster_legendary_actions", "monsters"
  add_foreign_key "monster_reactions", "monsters"
  add_foreign_key "monster_special_abilities", "monsters"
  add_foreign_key "mounts", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "multiclassing_prerequisites", "ability_scores"
  add_foreign_key "multiclassing_prerequisites", "multiclassings"
  add_foreign_key "multiclassing_proficiencies", "multiclassings"
  add_foreign_key "multiclassing_proficiencies", "proficiencies"
  add_foreign_key "multiclassing_proficiency_choices", "multiclassings"
  add_foreign_key "multiclassing_proficiency_choices", "proficiency_choices"
  add_foreign_key "multiclassings", "klasses"
  add_foreign_key "proficiency_choice_options", "proficiencies"
  add_foreign_key "proficiency_choice_options", "proficiency_choices"
  add_foreign_key "proficiency_choices", "klasses"
  add_foreign_key "race_proficiencies", "proficiencies"
  add_foreign_key "race_proficiencies", "races"
  add_foreign_key "rules", "rule_scopes"
  add_foreign_key "saving_throws", "ability_scores"
  add_foreign_key "shields", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "skills", "ability_scores"
  add_foreign_key "spell_classes", "klasses"
  add_foreign_key "spell_classes", "spells"
  add_foreign_key "spell_subclasses", "spells"
  add_foreign_key "spell_subclasses", "subclasses"
  add_foreign_key "spellcasting_infos", "class_spellcastings"
  add_foreign_key "spells", "damage_types"
  add_foreign_key "spells", "magic_schools"
  add_foreign_key "subclass_spell_prerequisites", "spells"
  add_foreign_key "subclass_spell_prerequisites", "subclasses"
  add_foreign_key "subclasses", "klasses"
  add_foreign_key "subfeature_options", "features"
  add_foreign_key "subrace_proficiencies", "proficiencies"
  add_foreign_key "subrace_proficiencies", "subraces"
  add_foreign_key "subraces", "races"
  add_foreign_key "tools", "equipment_categories", column: "equipment_categories_id"
  add_foreign_key "trait_languages_choice_options", "languages"
  add_foreign_key "trait_languages_choice_options", "trait_languages_choices"
  add_foreign_key "trait_languages_choices", "traits"
  add_foreign_key "trait_proficiencies", "proficiencies"
  add_foreign_key "trait_proficiencies", "traits"
  add_foreign_key "trait_proficiency_choice_options", "proficiencies"
  add_foreign_key "trait_proficiency_choice_options", "trait_proficiency_choices"
  add_foreign_key "trait_proficiency_choices", "traits"
  add_foreign_key "trait_races", "races"
  add_foreign_key "trait_races", "traits"
  add_foreign_key "trait_specific_damage_breaths", "damage_types"
  add_foreign_key "trait_specific_damage_breaths", "saving_throws"
  add_foreign_key "trait_specific_damage_breaths", "traits"
  add_foreign_key "trait_specific_spell_options", "spells"
  add_foreign_key "trait_specific_spell_options", "trait_specific_spells"
  add_foreign_key "trait_specific_spells", "traits"
  add_foreign_key "trait_specific_subtrait_options", "trait_specific_subtraits"
  add_foreign_key "trait_specific_subtrait_options", "traits"
  add_foreign_key "trait_specific_subtraits", "traits"
  add_foreign_key "trait_subraces", "subraces"
  add_foreign_key "trait_subraces", "traits"
  add_foreign_key "weapons", "equipment_categories", column: "equipment_categories_id"
end
