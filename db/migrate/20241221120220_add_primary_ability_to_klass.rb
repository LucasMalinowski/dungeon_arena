class AddPrimaryAbilityToKlass < ActiveRecord::Migration[7.1]
  def change
    add_column :klasses, :primary_ability, :string
  end
end
