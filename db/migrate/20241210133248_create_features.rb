class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :name
      t.integer :level
      t.text :description
      t.integer :parent_id
      t.references :klass, null: false, foreign_key: true
      t.references :subclass, null: true, foreign_key: true

      t.timestamps
    end

    create_table :feature_prerequisites do |t|
      t.string :prerequisite_type
      t.string :prerequisite_name
      t.string :prerequisite_value
      t.references :feature, null: false, foreign_key: true

      t.timestamps
    end

    create_table :subfeature_options do |t|
      t.references :feature, null: false, foreign_key: true
      t.integer :choice_quantity
      t.string :choice_type
      t.string :options_list
    end

    create_table :expertise_options do |t|
      t.references :feature, null: false, foreign_key: true
      t.integer :choice_quantity
      t.string :choice_type
      t.string :options_list
    end

    create_table :invocations do |t|
      t.references :feature, null: false, foreign_key: true
      t.string :name
    end
  end
end
