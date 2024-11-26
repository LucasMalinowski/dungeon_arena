class SavingThrow < ApplicationRecord
  has_many :class_saving_throws, dependent: :destroy
  has_many :klasses, through: :class_saving_throws
end
