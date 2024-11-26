class CreateClassSavingThrows < ActiveRecord::Migration[7.1]
  def change
    create_table :class_saving_throws do |t|
      t.references :klass, null: false, foreign_key: { to_table: :klasses }
      t.references :saving_throw, null: false, foreign_key: true

      t.timestamps
    end
  end
end
