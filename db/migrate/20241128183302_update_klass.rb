class UpdateKlass < ActiveRecord::Migration[7.1]
  def change
    remove_column :klasses, :index, :string
    remove_column :klasses, :url, :string
    remove_column :klasses, :hit_die, :integer
  end
end
