class CreateRulesAndRulesScopes < ActiveRecord::Migration[7.1]
  def change
    create_table :rule_scopes do |t|
      t.string :name
      t.text :description
    end

    create_table :rules do |t|
      t.string :name
      t.text :description
      t.references :rule_scope, foreign_key: true

      t.timestamps
    end
  end
end
