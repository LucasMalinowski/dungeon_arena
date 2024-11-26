class ClassProficiency < ApplicationRecord
  belongs_to :klass, class_name: 'Klass'
  belongs_to :proficiency
end
