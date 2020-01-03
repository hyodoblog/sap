class LaboratoryChoice < ApplicationRecord
  belongs_to :laboratory
  belongs_to :student

  validates :rank,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0
    }
end
