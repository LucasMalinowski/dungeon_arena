class ClassSavingThrow < ApplicationRecord
  belongs_to :klass, class_name: 'Klass'
  belongs_to :saving_throw
end
